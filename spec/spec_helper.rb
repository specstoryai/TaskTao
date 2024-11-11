ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner-sequel'
require 'factory_bot'
require 'faker'

# Load the application
require_relative '../config/application'

# Explicitly require models
Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    # Set up test database
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
    
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].clean_with(:truncation)
    
    # Load factories
    FactoryBot.find_definitions
  end

  config.around(:each) do |example|
    DatabaseCleaner[:sequel].cleaning do
      example.run
    end
  end

  # Add logging for tests
  SemanticLogger.add_appender(io: File.open('log/test.log', 'a'))
  SemanticLogger.default_level = :debug
end

def app
  TaskTao::Application
end 