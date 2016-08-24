#The basic file handler. This uses the notify gem (which, depending on the system uses rbnotify or inotify)
# to watch the filesystem for changes, and, when it detects a change, passes it to the proper file processor
# based on the extension. It does this by running each file through all the groups it knows about,
# and processing as soon as it finds a matching group. Groups are added to its knowledge base with add_group.
#
class PublisherTools::FileHandler
  attr_accessor :directory, :pubtools
  attr_reader :groups


  def initialize(directory, pubtools)
    @pubtools = pubtools
    @directory = directory
  end

  #Provided here so we can easily catch this in tests and make sure
  # we don't actually start listening to anything.
  def self.start_listening(directory, the_lambda)
    retries = 0
    begin
      Listen.to(directory, &the_lambda)
    rescue => e
      log_failure("PublisherTools file watcher encountered an unhandled exception:\n#{e.class} : #{e} \n  " + e.backtrace.join("\n  "))
      retries += 1
      retry if retries < 1000
    end
  end

  def self.log_failure(message)
    self.log_message(message, "error")
  end

  def self.log_message(message, level="info")
    Scribd::Logger.for("publisher_tools_file_watcher").send(level, message)
  end

  def add_group name, extension, handler=nil, &block
    begin
      @groups ||= {}
      @groups[name] = {
        :pattern => extension
      }
      if block_given?
        @groups[name][:block] = block
      else
        @groups[name][:block] = Proc.new{|addition| pubtools.send(handler, addition)}
      end
    end
  end

  def log_message(message, level="info")
    self.class.log_message(message, level)
  end

  def start!
    raise PublisherTools::Error::ArgumentError.new("no groups assigned") unless groups
    raise PublisherTools::Error::ArgumentError.new("missing watch directory") unless directory
    log_message("PublisherTools listening for new files in #{directory}")

    initial_additions = Dir[File.join(directory, '**', '**')].delete_if {|x| File.directory? x}
    handle_additions([], initial_additions, [])
    the_lambda = lambda{|mod, add, del| self.handle_additions(mod, add, del)}
    self.class.start_listening(directory, the_lambda)
  end

  # This method processes all the latest additions once and then exits. This is used for LibraryThing files,
  # which are processed in a cron job and thus cannot be processed with a filewatcher.
  def process_once!
    raise PublisherTools::Error::ArgumentError.new("no groups assigned") unless groups
    raise PublisherTools::Error::ArgumentError.new("missing watch directory") unless directory
    log_message("PublisherTools processing files one time for: #{directory}")

    initial_additions = Dir[File.join(directory, '**', '**')].delete_if {|x| File.directory? x}
    handle_additions([], initial_additions, [])
  end

  def handle_additions(modified, added, deleted, import = nil)
      potential_additions = modified.concat(added).select{|path| file_ready?(path, import)}
      message = {"added: " => potential_additions, "deleted: " => deleted}.delete_if {|k,v| v.blank?}
      message = "Nothing to add, potentials: #{modified}, #{added}, #{deleted}" if message.blank?
      log_message(message)

      return if potential_additions.blank?
      enqueue_additions(potential_additions)
      return true
  end

  # A file is 'ready' if:
  # 1: It is a file.
  # 2: It is readable
  # 3: It's not zero length
  # 4: It's not a temporary upload file(matches .in means temporary)
  # 5: The publisher is not marked as inactive
  def file_ready?(path, import)
    File.file?(path) && File.readable?(path) && !File.zero?(path) &&
      !(File.basename(path) =~ /\.in.*/) && (import.try(:active_publisher?) || active?(path))
  end

  def get_file_details(filepath)
    file_name = File.basename(filepath)
    ftp_path = File.dirname(filepath).gsub(self.directory.to_s, "")
    dirs = ftp_path.split(File::SEPARATOR)
    #Depending on if our path includes a leading / or not...ex:
    # path: /a/b/c ==> ["", "a", "b", "c"]
    # path: a/b/c  ==> ["a", "b", "c"]
    # this handles both cases.
    ftp_dir = dirs[0]
    ftp_dir = dirs[1] if ftp_dir.blank?

    return file_name, ftp_path, ftp_dir
  end

  private

  def enqueue_additions additions
    filter_through_groups(additions) do |group_name, addition|
      log_message("processing #{addition} by group #{group_name}", "info")
      groups[group_name][:block].call addition
      log_message("Completed #{addition} by group #{group_name}", "info")
    end
  end

  def filter_through_groups files
    found = Set.new
    files.each do |file|
      groups.each do |group_name, group|
        pattern = group[:pattern]
        if Pathname.new(file).realpath.to_s =~ pattern
          yield group_name, file
          found << file
          #Only match on the first group that matches.
          break
        end
      end
    end
    found
  end

  def active? path
    # Checks if publisher has been marked inactive
    _, _, ftpdir = get_file_details path
    publisher = PublisherToolsConfig.find_by_ftpdir(ftpdir)
    !!publisher.try(:active?)     # If no publisher config record, consider publisher inactive
  end
end
