module Apikit
  class Client
    attr_accessor :api_endpoint

    def initialize(api_endpoint)
      @api_endpoint = api_endpoint
    end

    def get(path, options = {})
      request :get, path, options
    end

    def post(path, options = {})
      request :post, path, options
    end

    def put(path, options = {})
      request :put, path, options
    end

    def delete(path, options = {})
      request :delete, path, options
    end

    def request(method, path, options = {})
      response = agent.call(method, URI::Parser.new.escape(path.to_s), nil, options)
      response.data
    end

    private

    def agent
      @agent ||= Sawyer::Agent.new(api_endpoint) do |http|
        http.headers[:content_type] = "application/json"
      end
    end

  end
end


