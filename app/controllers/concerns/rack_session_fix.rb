module RackSessionFix
  extend ActiveSupport::Concern
  included do
    before_action { request.env["rack.session"] ||= {} }
  end
end
