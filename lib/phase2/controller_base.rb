module Phase2
  class ControllerBase
    attr_reader :req, :res, :already_built_response

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      if @already_built_response
        raise "Cannot render or redirect twice during a single request"
      else
        res['location'] = url
        res.status = 302
        @already_built_response = true
      end
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      if @already_built_response
        raise "Cannot render or redirect twice during a single request"
      else
    
        res.content_type = content_type
        res.body = content
        @already_built_response = true
      end
    end
  end
end
