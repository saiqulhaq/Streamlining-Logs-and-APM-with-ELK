require_relative "boot"

require "rails/all"
require_relative '../app/middleware/request_id_setter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hello
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, see:
    #   https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#config-autoload-lib-ignore.
    config.autoload_lib(ignore: %w[assets tasks])

    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch("REDIS_URL") { "redis://redis:6379/1" },
      namespace: "cache"
    }

    # Set Sidekiq as the back-end for Active Job.
    config.active_job.queue_adapter = :sidekiq

    # Mount Action Cable outside the main process or domain.
    config.action_cable.mount_path = nil
    config.action_cable.url = ENV.fetch("ACTION_CABLE_FRONTEND_URL") { "ws://localhost:28080" }

    # Only allow connections to Action Cable from these domains.
    origins = ENV.fetch("ACTION_CABLE_ALLOWED_REQUEST_ORIGINS") { "http:\/\/localhost*" }.split(",")
    origins.map! { |url| /#{url}/ }
    config.action_cable.allowed_request_origins = origins

    config.middleware.insert_after ActionDispatch::RequestId, RequestIdSetter
    config.logger = LogStashLogger.new(
      type: :file,
      path: "#{Rails.root}/log/application.log",
    )

    def self.log_level_to_string(level)
      case level
      when 0 then 'debug'
      when 1 then 'info'
      when 2 then 'warn'
      when 3 then 'error'
      when 4 then 'fatal'
      when 5 then 'unknown'
      else 'unknown'
      end
    end
  end
end
