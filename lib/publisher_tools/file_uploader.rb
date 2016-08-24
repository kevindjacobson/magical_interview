#This handles everything to do with uploading thumbnails. 
#It has three important methods: upload_to_scribd, upload_to_s3, and download_from_s3
# The normal use is to first upload the thumbnail from (booksftp) to s3, then 
# download the thumbnail from s3 and upload it to scribd. 
# The first step of uploading to s3 is there so we can offload this work to another server at some point, 
# if thumbnail uploading gets to be too slow. Also, this gives us a more or less permenant copy of the thumbnail.
module PublisherTools
  class FileUploader
    def self.bucket
      AppConfig.booksftp[:bucket]
    end

    def self.upload_to_s3(file_path, s3_key)      
      result = nil

      if Aws.upload_private(bucket, s3_key, File.open(file_path, "rb"))
        result = s3_key
      else
        result = false
      end
      return result
    end

    def self.download_from_s3(s3_key, base_path)
      destination = File.join(base_path, s3_key)
      FileUtils.mkdir_p(File.dirname(destination))

      if Aws.download(bucket, s3_key, destination)
        return destination
      else
        return nil
      end
    end

    def self.s3_key(file_path, handler)
      filename, ftp_path, _ = handler.get_file_details(file_path)
      return File.join(ftp_path, filename)
    end
  end #class
end #module
