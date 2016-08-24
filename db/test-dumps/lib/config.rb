$:.unshift File.expand_path('..', __FILE__)

require 'pathname'
require 'ostruct'
require 'yaml'

require 'console_logger'
require 'database'
require 'database_dump'
require 'project'

ROOT = Pathname.new File.expand_path('../..', __FILE__)

#----- Databases ---------------------------------------------------------------
db_config = YAML.load_file(ROOT + "config/config.yml") || raise("Can't load config!")

DATABASES = db_config['databases'].map do |attrs|
  Database.new(attrs)
end

PROJECTS = db_config['projects'].map do |name, attrs|
  Project.new(name, attrs)
end

#----- Settings ----------------------------------------------------------------
config = {
  dumps_directory: ROOT + 'dumps',
  database_prefix: ENV['CI_DB_PREFIX'],
  database_env:    ENV['RAILS_ENV'] == 'development' ? 'dev' : 'test',
  mysql_exe:       `which mysql`.chomp,
  mysqladmin_exe:  `which mysqladmin`.chomp,
  mysql_options:   '-uroot --default-character-set=utf8mb4',
  dump_command:    'mysqldump --quick --single-transaction %dump_options%',
  ssh_command:     "ssh -o StrictHostKeyChecking=no -C %user%@%host% '%command%'",
  line_width:      110,
}

config[:database_name_format]        = "#{config[:database_prefix]}#{config[:database_env]}_%database%%suffix%"
config[:database_dump_format]        = "#{config[:dumps_directory]}/%database%.sql"
config[:database_dump_custom_format] = "#{config[:dumps_directory]}/%database%_custom.sql"
config[:database_host]               = '127.0.0.1'
config[:database_name_width]         = DATABASES.map(&:name).map(&:size).max
config[:database_description_width]  = DATABASES.map(&:description).map(&:size).max
config[:dev_contents_file]           = "#{config[:dumps_directory]}/dev_contents.sql"

CONFIG = OpenStruct.new(config)

#----- Runtime -----------------------------------------------------------------

# Synchronize all messages being printed to console
$stdout.sync = true
