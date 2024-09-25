class ApplicationController < ActionController::Base
  # around_action :add_request_id_to_payload

  # private

  # def add_request_id_to_payload
  #   ActiveSupport::Notifications.instrument("request.custom", request_id: Current.request_id) do
  #     yield
  #   end
  # end
end
