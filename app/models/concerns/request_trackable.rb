module RequestTrackable
  extend ActiveSupport::Concern

  included do
    before_create :set_request_id
  end

  private

  def set_request_id
    self.request_id = Current.request_id
  end
end
