module Apikit
  class Configuration
    attr_reader :faraday
    attr_accessor :faraday

    def initialize

    end

    # Faraday default stack is
    #   self.request :url_encoded
    #   self.adapter Faraday.default_adapter
    def faraday=(faraday)
      handlers = faraday.builder.handlers
      unless handlers.empty?  || handlers.last.klass < Faraday::Adapter
        faraday.adapter Faraday.default_adapter
      end
      @faraday = faraday
    end

    def self.default
      new
    end
  end
  Config = Configuration

end
