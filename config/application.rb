require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gasolineras
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
  	config.active_record.raise_in_transactional_callbacks = true
    ##config.middleware.delete ActionDispatch::Session::CookieStore


  	config.middleware.insert_before 0, "Rack::Cors" do
  	  allow do
  	    origins '*'
  	    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  	  end
  	end

  end
end
