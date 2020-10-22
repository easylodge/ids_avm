class IdsAvm::Configuration
  attr_accessor :api_key, :url

  def initialize(args = {})
    @api_key = args[:api_key] || ENV['IDS_AVM_API_KEY']
    @url = args[:url] || ENV['IDS_AVM_URL']
  end
end