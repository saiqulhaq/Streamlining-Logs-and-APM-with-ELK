Rails.application.configure do
  config.log_tags = [ :request_id, proc { ElasticAPM.log_ids } ]
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/application_server.log"
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format id)
    ElasticAPM.log_ids do |transaction_id, span_id, trace_id|
      {
        level: event.payload[:level],
        request_id: event.payload[:request_id] || Current.request_id,
        ip: event.payload[:ip],
        params: event.payload[:params].except(*exceptions),
        transaction_id: transaction_id,
        span_id: span_id,
        trace_id: trace_id
      }
    end
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
