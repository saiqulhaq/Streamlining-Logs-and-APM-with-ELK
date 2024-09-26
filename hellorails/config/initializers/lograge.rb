Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/application_server.log"
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format id)
    {
      level: event.payload[:level],
      request_id: event.payload[:request_id] || Current.request_id,
      ip: event.payload[:ip],
      params: event.payload[:params].except(*exceptions)
    }
  end

  config.lograge.custom_payload do |controller|
    {
      level: ::Hello::Application.log_level_to_string(controller.logger.level),
      request_id: controller.request.request_id,
      ip: controller.request.remote_ip
    }
  end
  # config.lograge.keep_original_rails_log = true
end
