require 'ids_avm/search'
require 'active_support'

module IdsAvm
  class Api
    include IdsAvm::Search

    attr_accessor :api_key, :api_url

    def initialize(args = {})
      @api_key = args[:api_key]
      @api_url = args[:api_url]
    end

    def validate_authorisation
      raise("IDS AVM Base url missing!") unless @api_url.present?
      raise("IDS AVM API key missing!") unless @api_key.present?
    end

    def headers
      { 'Content-Type': 'application/json', 'Accept': 'application/json', 'x-api-key': @api_key }
    end

    def options(query)
      { query: query, headers: headers }
    end

    def get(endpoint, query={})
      validate_authorisation

      HTTParty.get(@api_url + endpoint, options(query)).parsed_response
    end

  end
end
