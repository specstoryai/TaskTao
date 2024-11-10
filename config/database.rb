require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/tasktao_development')

Sequel::Model.plugin :validation_helpers 