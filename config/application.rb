require 'sinatra/base'
require 'sinatra/reloader'
require 'dotenv/load'
require 'semantic_logger'
require_relative 'database'

# Configure logging
SemanticLogger.default_level = :info
SemanticLogger.add_appender(
  io: $stdout,
  formatter: :color
)

# Verify required environment variables are set
%w[USERNAME PASSWORD].each do |var|
  unless ENV[var]
    raise "ERROR: Environment variable #{var} is required but not set. Please set it in .env file or in your environment."
  end
end

module TaskTao
  class Application < Sinatra::Base
    # Include logging
    include SemanticLogger::Loggable

    configure :development do
      register Sinatra::Reloader
      logger.level = :debug
    end

    configure :production do
      logger.level = :info
    end

    configure do
      set :root, File.dirname(__FILE__) + '/../'
      set :views, settings.root + 'app/views'
      set :public_folder, settings.root + 'public'
      enable :method_override
      enable :logging
      enable :sessions
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    end

    # Add request logging
    use Rack::CommonLogger, SemanticLogger[Application]

    # Log all requests
    before do
      logger.debug "Request: #{request.request_method} #{request.path}",
        params: params.inspect,
        headers: request.env.select { |k,v| k.start_with?('HTTP_') }
    end

    # Log all responses
    after do
      logger.debug "Response: #{response.status}"
    end

    # Load all models
    Dir[File.join(settings.root, 'app', 'models', '*.rb')].each { |file| require file }
    
    # Load all routes
    Dir[File.join(settings.root, 'app', 'routes', '*.rb')].each { |file| require file }
  end
end 