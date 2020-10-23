module IdsAvm::Request
  extend self

  def validate_authorisation
    raise("IDS AVM Base url missing!") unless IdsAvm.configuration.url.present?
    raise("IDS AVM API key missing!") unless IdsAvm.configuration.api_key.present?
  end

  def headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'x-api-key' => IdsAvm.configuration.api_key }
  end

  def options(query)
    { query: query, headers: headers }
  end

  def get(url, query={})
    validate_authorisation
    HTTParty.get(IdsAvm.configuration.url + url, options(query)).parsed_response
  end
end