class Project
  attr_accessor :name
  attr_accessor :database_names

  def initialize(name, attrs = {})
    @name           = name
    @database_names = attrs['databases'] || []
  end

  def databases
    @databases ||= if database_names.empty?
      DATABASES
    else
      dbs = DATABASES.find_all { |db| database_names.include?(db.name) }
      missing_dbs = database_names - dbs.map(&:name)
      if missing_dbs.any?
        abort "Missing databases for project #{name}: #{missing_dbs.join(', ')}"
      end
      dbs
    end
  end
end
