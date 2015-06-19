module Apikit
  class Client
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
      request :get, path, options
    end

    # @return [Sawyer::Resource]
    def post(path, options = {})
      request :post, path, options
    end

    # @return [Sawyer::Resource]
    def put(path, options = {})
      request :put, path, options
    end

    # @return [Sawyer::Resource]
    def delete(path, options = {})
      request :delete, path, options
    end

    # @return [Sawyer::Resource]
    def request(method, path, options = {})
      @last_response = response = agent.call(method, URI::Parser.new.escape(path.to_s), nil, options)
      response.data
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
