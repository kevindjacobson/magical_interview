require 'open3'
require 'fileutils'

class DatabaseDump
  attr_reader :name

  def self.dumps
    @dumps ||= {}
  end

  def self.for(name)
    dumps[name] ||= new(name)
  end

  def self.stdout
    dumps[:stdout] = new(nil)
  end

  def self.close
    dumps.keys.each do |name|
      next if name == :stdout
      dumps.delete(name).close
    end
  end

  def initialize(name)
    FileUtils.mkdir_p(CONFIG.dumps_directory)
    @name = name
  end

  def append(cmd)
    error = nil
    Open3.popen3(cmd) do |stdin, stdout, stderr|
      while line = stdout.gets
        # Skip unnecessary lines ...
        next if line =~ /^-- Dump completed on/

        # ... and set autoincrements to 1 ...
        line.sub!(/\bAUTO_INCREMENT=\d+\b/, 'AUTO_INCREMENT=1')
        # ... and remove compression ...
        line.sub!(/\s+ROW_FORMAT=COMPRESSED\b/, '')
        line.sub!(/\s+KEY_BLOCK_SIZE=\d+\b/, '')
        # ... and remove partitioning ...
        line.sub!(%r{^/\*!50100 PARTITION BY.*$|^PARTITIONS \d+ \*/|^[\( ]PARTITION.*(,|\) \*/)}, '')
        # ... and fix default html_assets_queue backet
        line.sub!(%r/^(\s*`bucket` .*? DEFAULT ')html.scribd.com(')/, '\1dev.scribd.com\2')
        # ... and then write result to the given file
        file.write line
      end
      error = stderr.read.to_s.strip
      error = nil if error == ''
    end
    # Flush everything we have dumped to the file
    file.flush

    error
  end

  def file
    @file ||= name ? File.new(file_name, 'w+') : STDOUT
  end

  def close
    @file.close
    @file = nil
  end

  def file_name
    CONFIG.dumps_directory + "#{name}.sql"
  end

  def file_name_custom
    env = CONFIG.database_env
    CONFIG.dumps_directory + "#{env}_#{name}_custom.sql"
  end
end
