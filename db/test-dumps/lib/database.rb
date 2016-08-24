class Database
  # Local database name (required).
  attr_accessor :name
  # Database host (required).
  attr_accessor :hostname
  # DNS name or IP address of the MySQL host to connect (optional, default to `127.0.0.1`).
  attr_accessor :connect_hostname
  # MySQL port to connect to.
  attr_accessor :port
  # User for login (optional, default `root`);
  attr_accessor :username
  # Password for login (optional, no password by default).
  attr_accessor :password
  # Database name on remote host (required).
  attr_accessor :database
  # Whether schema_migrations should be dumped from this database (optional, default false).
  attr_accessor :migrations
  # An array of tables to dump (optional, by default dumps all tables).
  attr_accessor :tables
  # An array of tables to ignore (optional, by default dumps all tables).
  attr_accessor :ignore
  # Whether database name is just a shard prefix.
  attr_accessor :shard_prefix
  # List of queries to run after database dump import.
  attr_accessor :post_import

  def initialize(attrs = {})
    @name             = attrs['name']
    @hostname         = attrs['hostname']
    @connect_hostname = attrs['connect_hostname'] || '127.0.0.1'
    @port             = attrs['port'] || 3306
    @username         = attrs['username'] || 'root'
    @password         = attrs['password']
    @database         = attrs['database']
    @migrations       = !!attrs['migrations']
    @tables           = attrs['tables'] || []
    @ignore           = attrs['ignore'] || []
    @shard_prefix     = !!attrs['shard_prefix']
    @post_import      = attrs['post_import'] || []
  end

  def migrations?
    migrations
  end

  def shard_prefix?
    shard_prefix
  end

  def description
    "#{database} at #{hostname}"
  end

  def formatted_name(suffix)
    name = CONFIG.database_name_format.gsub('%database%', self.name.to_s).gsub('%suffix%', suffix.to_s)
    name << '_00001' if shard_prefix?
    name
  end

  def dump_path
    DatabaseDump.for(name).file_name
  end

  def dump_custom_path
    DatabaseDump.for(name).file_name_custom
  end
end
