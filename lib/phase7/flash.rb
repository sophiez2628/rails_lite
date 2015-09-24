module Phase7

  class Flash
    attr_reader :flash, :flash_now

    def initialize(req)
      cookie = req.cookies.find { |cook| cook.name == '_rails_lite_app_flash'}
      if cookie
        @flash_now = JSON.parse(cookie.value)
        @flash = {}
      else
        @flash_now = {}
        @flash = {}
      end
    end

    def now
       @flash_now
    end

    def [](key)
      flash[key] || flash_now[key]
    end

    def []=(key, val)
      flash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      cookie = WEBrick::Cookie.new('_rails_lite_app_flash', flash.to_json)
      cookie.path = '/'
      res.cookies << cookie
    end

  end
end
