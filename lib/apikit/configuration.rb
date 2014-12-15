module Apikit
  class Configuration
    attr_reader :faraday_options

    def initialize

    end

    def config_faraday(&config_block)
      @faraday_options = config_block
    end

    def self.default
      new
    end
  end
  Config = Configuration

end
