# ActiveSupport::Notifications.subscribe "request.custom" do |name, start, finish, id, payload|
#   Rails.logger.info "Custom request: #{payload[:request_id]}"
#   # You can also send metrics to your observability platform here
# end
