require 'sinatra/base'
require 'sinatra/reloader'
require 'dotenv/load'
require_relative 'database'

# Verify required environment variables are set
%w[USERNAME PASSWORD].each do |var|
  unless ENV[var]
    raise "ERROR: Environment variable #{var} is required but not set. Please set it in .env file or in your environment."
  end
end

module TaskTao
  class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    configure do
      set :root, File.dirname(__FILE__) + '/../'
      set :views, settings.root + 'app/views'
      set :public_folder, settings.root + 'public'
      enable :method_override
    end

    # Load all models
    Dir[File.join(settings.root, 'app', 'models', '*.rb')].each { |file| require file }
    
    # Load all routes
    Dir[File.join(settings.root, 'app', 'routes', '*.rb')].each { |file| require file }
  end
end 