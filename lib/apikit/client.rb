module Apikit
  class Client
    include Wisper::Publisher
    attr_accessor :api_endpoint, :config
    attr_reader :last_response

    # options:
    def initialize(api_endpoint, config = nil)
      @api_endpoint = api_endpoint
      @config = (config || Configuration.new)
      yield @config if block_given?
    end

    # options:
    #   query:
    # @return [Sawyer::Resource]
    def get(path, options = {})
      request :get, path, nil, options
    end

    # @return [Sawyer::Resource]
    def post(path, data, options = {})
      request :post, path, data, options
    end

    # @return [Sawyer::Resource]
    def put(path, data, options = {})
      request :put, path, data, options
    end

    # @return [Sawyer::Resource]
    def delete(path, options = {})
      request :delete, path, nil, options
    end

    # @return [Sawyer::Resource]
    def request(method, path, data, options = {})
      @last_response = response = agent.call(method, URI::Parser.new.escape(path.to_s), data, options)
      response.data.tap do |data|
        broadcast :request_fail, response.status, data, response unless [200, 201].include?(response.status)
      end
    end

    private

    def agent
      @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:content_type] = "application/json"
      end
    end

    def sawyer_options
      {}.tap do |opts|
        opts[:faraday] = config.faraday if config.faraday
      end
    end
  end
end
