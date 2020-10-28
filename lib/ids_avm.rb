require 'ids_avm/configuration'
require 'ids_avm/request'
require 'ids_avm/search'
require 'ids_avm/version'
require 'httparty'
require 'ids_avm/railtie' if defined?(Rails)

module IdsAvm
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
