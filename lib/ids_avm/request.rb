class IdsAvm::Request

  def validate_authorisation
    raise("IDS AVM Base url missing!") unless IdsAvm::Configuration.new.url.present?
    raise("IDS AVM API key missing!") unless IdsAvm::Configuration.new.api_key.present?
  end

  def headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'x-api-key' => IdsAvm::Configuration.new.api_key }
  end

  def options(query)
    { query: query, headers: headers }
  end


  def get(url, query={})
    validate_authorisation
    HTTParty.get(IdsAvm::Configuration.new.url + url, options(query))
  end
end