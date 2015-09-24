require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    attr_reader :cookie_value

    def initialize(req)
      cookie = req.cookies.find { |cook| cook.name == '_rails_lite_app'}
      #instance of the webrick cookie object
      if cookie
        @cookie_value = JSON.parse(cookie.value)
      else
        @cookie_value = {}
      end
    end

    def [](key)
      cookie_value[key]
    end

    def []=(key, val)
      cookie_value[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', cookie_value.to_json)
    end
    #
  end
end
