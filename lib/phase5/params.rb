require 'uri'
require 'byebug'

module Phase5
  class Params
    attr_reader :params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      parse_www_encoded_form(req.query_string) unless req.query_string.nil?
      parse_www_encoded_form(req.body) unless req.body.nil?

      route_params.each do |key, value|
        params[key] = value
      end

      params
    end

    #new is a class method, initialize is called

    def [](key)
      params[key] || params[key.to_s] || params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      array_version = URI::decode_www_form(www_encoded_form)

      array_version.each do |key, value|
        current = params
        parse_results = parse_key(key)
        if parse_results.count > 1
          parse_results.each_with_index do |key, index|
            if (parse_results.count - 1) == index
              current[key] = value
            else
              current[key] ||= {}
              current = current[key]
            end
          end
        else
          params[key] = value
        end
      end
      params
    end

    def params
      @params ||= {}
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      array_keys = key.split(/\]\[|\[|\]/)
    end
  end
end
