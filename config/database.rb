require 'sequel'

case ENV['RACK_ENV']
when 'test'
  DB = Sequel.connect('postgres://localhost/tasktao_test')
else
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/tasktao_development')
end

Sequel::Model.plugin :validation_helpers