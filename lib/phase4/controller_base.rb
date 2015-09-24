require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    attr_reader :session
    def redirect_to(url)
      super
      session.store_session(res)
      flash.store_flash(res)
    end

    def render_content(content, content_type)
      super
      session.store_session(res)
      flash.store_flash(res)
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(req)
    end
  end
end
