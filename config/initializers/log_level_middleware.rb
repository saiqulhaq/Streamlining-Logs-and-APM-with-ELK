class LogLevelMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    Thread.current[:log_level] = Rails.logger.level
    @app.call(env)
  ensure
    Thread.current[:log_level] = nil
  end
end

Rails.application.config.middleware.insert_before Rails::Rack::Logger, LogLevelMiddleware
