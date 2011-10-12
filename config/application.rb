$LOAD_PATH.unshift('.')
require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
  Bundler.require(:default, Rails.env)
end

# API Engines
require 'app/api/v1_0'

module IntermodalExample
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    def default_middleware_stack
      ActionDispatch::MiddlewareStack.new.tap do |middleware|
        #middleware.use ::Rack::Lock unless config.allow_concurrency
        middleware.use ::Rack::Runtime
        middleware.use ::Rails::Rack::Logger
        middleware.use ::ActionDispatch::RemoteIp, config.action_dispatch.ip_spoofing_check, config.action_dispatch.trusted_proxies
        middleware.use ::Rack::Sendfile, config.action_dispatch.x_sendfile_header
        middleware.use ::ActionDispatch::Callbacks, !config.cache_classes

        if config.session_store
          middleware.use config.session_store, config.session_options
          middleware.use ::ActionDispatch::Flash
        end

        #middleware.use ::ActionDispatch::ParamsParser
        middleware.use ::Rack::MethodOverride
        middleware.use ::ActionDispatch::Head
      end
    end

    # ActiveRecord 3.1 inserts a Rack middleware for managing query caches
    # Since there is no configuration to actually disable it, then this kludge
    # comes in later to remove it from the stack.
    #
    # QueryCaching needs to be disabled so that the tests work. It remains to be
    # seen if the tests can be rewritten with QueryCache in mind. I have not
    # tested this in server mode yet.
    initializer 'intermodal_example.hack_active_record', :after => 'eager_load!' do
      config.middleware.delete ActiveRecord::QueryCache
    end
  end
end
