module PublisherTools
  class PublisherTools
    FILE_SIZE_LIMIT = 250 # MB. Conversion will run out of mem if file over size limit
    attr_accessor :standard_handler, :hidden_handler, :library_thing_file_handler, :hidden_file_path
    def initialize(watchpath = nil, hiddenroot = nil)
      @watch_path = Pathname.new(watchpath || self.class.default_watch_path).realpath
      @hidden_file_path = Pathname.new(hiddenroot ||  self.class.default_hidden_path).realpath

      @default_prefix = "\\A#{Regexp.quote(@watch_path.to_s)}/[^/]+/.+\."
      @hidden_prefix = "\\A#{Regexp.quote(@hidden_file_path.to_s)}/[^/]+/.+\."

      @standard_handler = create_file_handler(@watch_path)
      @hidden_handler = create_file_handler(@hidden_file_path)
      @library_thing_file_handler = create_file_handler(@watch_path)
    end

    def watch_files!
      add_handlers!
      @standard_handler.start!
    end

    def process_library_thing_files!
      library_thing_file_handler.add_group(:library_thing, extensions(:library_thing, "xml"), :library_thing_handler)
      library_thing_file_handler.process_once!
    end

    #This is added for tests. Stubbing out "new" is bad juju.
    def create_file_handler(watched_dir)
      return FileHandler.new(watched_dir, self)
    end

    def add_handlers!
      #if we specified the upload handlers, only add handlers that upload to s3, or 
      #can not fail. Otherwise, add the processing-handlers.


      standard_handler.add_group :upload, extensions(:default, 'xls', 'csv', 'xml', 'epub', 'pdf'), :submission_handler
      standard_handler.add_group :zip, extensions(:default, 'zip'), :zip_handler
      standard_handler.add_group :thumbnail, extensions(:default, 'jpeg','jpg','png', 'gif'), :thumbnail_handler
      standard_handler.add_group :bowker, extensions(:default, '\d\d\d'), :bowker_handler

      hidden_handler.add_group :metadata, extensions(:hidden, 'xls', 'csv', 'xml'), :metadata_handler
      hidden_handler.add_group :documents, extensions(:hidden, 'epub', 'pdf'), :document_handler
    end

    def submission_handler(addition)
      _, _, ftp_dir = @standard_handler.get_file_details(addition)
      result = ::PublisherTools::PublisherToolsSubmission.create_submission_from_path(addition, PublisherToolsConfig.find_by_ftpdir(ftp_dir), standard_handler)
      result.local_path = hide_file(addition)
      result.file_handler = hidden_handler
      result.process!
    end

    def metadata_handler(addition)
      _, _, ftp_dir = hidden_handler.get_file_details(addition)
      result = ::MetadataParser::PublisherTools::ParserHandler.add_products_to_queue(addition, PublisherToolsConfig.find_by_ftpdir(ftp_dir)) 
    end

    def document_handler(addition)
      status, size = self.class.check_file_size(addition, FILE_SIZE_LIMIT)
      raise Error::FileTooBigError.new(size, FILE_SIZE_LIMIT) unless status
      file_name, _, ftp_dir = hidden_handler.get_file_details(addition)
      result = ::PublisherTools::DocUploader.upload(addition, file_name, ftp_dir)
    end

    def zip_handler(addition)
      PublisherTools::Zip.unzip(addition)
    end

    def thumbnail_handler(addition)
      status, size = self.class.check_file_size(addition, FILE_SIZE_LIMIT)
      raise Error::FileTooBigError.new(size, FILE_SIZE_LIMIT) unless status 

      begin
        file_name, _, ftp_dir = standard_handler.get_file_details(addition)

        result = ::PublisherTools::ThumbnailUploader.upload_to_s3(addition, file_name, ftp_dir)
        if result
          hide_file(addition)
        else
          log_error("Failed to upload #{addition} to S3")
        end
      rescue RightAws::AwsError => e
        log_error("Aws Error on thumbnail upload #{e} \n #{e.backtrace.join("\n")}")
      end
    end

    # For Bowker data, copy the data to a temporary directory where it will get picked up by Besar's nightly jobs.
    # Then hide the file in booksftp-hidden
    def bowker_handler(addition)
      FileUtils.mkdir_p AppConfig.bowker_temp_directory
      FileUtils.chown("deploy", nil, AppConfig.bowker_temp_directory)

      FileUtils.cp(addition, AppConfig.bowker_temp_directory)

      # Back the file up to S3
      _, _, ftp_dir = standard_handler.get_file_details(addition)
      result = ::PublisherTools::PublisherToolsSubmission.create_submission_from_path(addition, PublisherToolsConfig.find_by_ftpdir(ftp_dir), standard_handler)
      result.success = true
      result.save!

      # Set the owner of the file and the directory to deploy so it can be removed from olap-app01 after processing.
      FileUtils.chown("deploy", nil, Dir.glob("#{AppConfig.bowker_temp_directory}/*"))
    end

    # LibraryThing data needs to be preprocessed into a delimited text file before getting moved to a temporary directory to get picked up by Besar's nightly jobs.
    # Then it gets stashed in booksftp-hidden

    def library_thing_handler(addition)
      # First, back up the file to S3.
      _, _, ftp_dir = @library_thing_file_handler.get_file_details(addition)
      result = ::PublisherTools::PublisherToolsSubmission.create_submission_from_path(addition, PublisherToolsConfig.find_by_ftpdir(ftp_dir), @library_thing_file_handler)
      result.success = true
      result.save!

      regex = /\/(?:works_to_|workto)?([^\/]+)_current\.xml/

      if match = addition.match(regex)
        library_thing_data_type = match.captures[0]
      end
      library_thing_data_type = library_thing_data_type.chop if library_thing_data_type[-1, 1] == "s"

      parser = "MetadataParser::LibraryThing::WorksTo#{library_thing_data_type.capitalize}".constantize

      parser.import_objects(File.new(addition))

      delimited_text_file = File.expand_path("works_to_#{library_thing_data_type}")

      FileUtils.chown("deploy", nil, delimited_text_file)

      FileUtils.mkdir_p AppConfig.library_thing_temp_directory
      FileUtils.chown("deploy", nil, AppConfig.library_thing_temp_directory)

      FileUtils.cp(delimited_text_file, AppConfig.library_thing_temp_directory)

      FileUtils.chown("deploy", nil, Dir.glob("#{AppConfig.library_thing_temp_directory}/*"))
    end

    def log_error(message, level="info")
      Scribd::Logger.for("publisher_tools_file_watcher").send(level, message)
    end

    #Moves the file found at file_path to hidden_root/<path>
    #returns the new path to the file.
    def hide_file(filepath)
      file_name, ftp_path, ftp_dir = standard_handler.get_file_details(filepath)
      new_dir = File.join(self.hidden_file_path, ftp_path)

      new_path = File.join(new_dir, file_name)

      FileUtils.mkdir_p(new_dir)
      FileUtils.mv(filepath, new_path)
      return new_path
    end

    def remove_file(file)
      FileUtils.rm file
    end

    def self.default_watch_path
      return File.join(Rails.root, 'booksftp')
    end

    def self.default_hidden_path
      return File.join(Rails.root, 'hidden')
    end

    def extensions(type, *exts)
      /#{self.instance_variable_get("@#{type}_prefix")}(?:#{exts.join("|")})\Z/i
    end

    def self.check_file_size(file, limit)
      size = File.size(file) / 1048576.0  # convert bytes into MBs
      return size < limit, size
    end
  end
end
