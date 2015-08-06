module Apikit
  class Configuration
    attr_reader :faraday
    attr_accessor :agent_factory

    def initialize
      @agent_factory = default_agent_factory
    end

    # Faraday default stack is
    #   self.request :url_encoded
    #   self.adapter Faraday.default_adapter
    def faraday=(faraday)
      handlers = faraday.builder.handlers
      unless handlers.empty? || handlers.last.klass < Faraday::Adapter
        faraday.adapter Faraday.default_adapter
      end
      @faraday = faraday
    end

    def self.default
      new
    end

    def default_agent_factory
      ->(api_endpoint, sawyer_options) {
        Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
          http.headers[:content_type] = "application/json"
        end
      }
    end
  end
  Config = Configuration
end
