require 'sequel'
require 'dotenv/load'
require_relative 'config/database'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DB, "db/migrations")
    end
  end

  desc "Rollback migration"
  task :rollback do
    Sequel.extension :migration
    version = DB[:schema_info].first[:version]
    Sequel::Migrator.run(DB, "db/migrations", target: version - 1)
    puts "Rolled back to version #{version - 1}"
  end
end 