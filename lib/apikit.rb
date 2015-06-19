require 'sawyer'

require "apikit/version"
require "apikit/configuration"
require 'apikit/client'

module Apikit
  class << self
    attr_reader :configuration

    def configuration
      @configuration ||= Configuration.new
    end
    alias_method :config, :configuration

    def reset_config
      @configuration = Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
