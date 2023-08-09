require 'ids_avm/api'
require 'httparty'

RSpec.describe IdsAvm::Api do
  let(:api_key) { 'my_api_key' }
  let(:api_url) { 'https://example.com/api' }
  let(:api) { IdsAvm::Api.new(api_key: api_key, api_url: api_url) }

  describe '#validate_authorisation' do
    context 'when api_url is missing' do
      let(:api_url) { nil }

      it 'raises an error' do
        expect { api.validate_authorisation }.to raise_error('IDS AVM Base url missing!')
      end
    end

    context 'when api_key is missing' do
      let(:api_key) { nil }

      it 'raises an error' do
        expect { api.validate_authorisation }.to raise_error('IDS AVM API key missing!')
      end
    end

    context 'when api_key and api_url are present' do
      it 'does not raise an error' do
        expect { api.validate_authorisation }.not_to raise_error
      end
    end
  end

  describe '#headers' do
    it 'returns the correct headers' do
      expect(api.headers).to eq({ 'Content-Type': 'application/json', 'Accept': 'application/json', 'x-api-key': api_key })
    end
  end

  describe '#options' do
    it 'returns the correct options' do
      query = { foo: 'bar' }
      expect(api.options(query)).to eq({ query: query, headers: api.headers })
    end
  end

  describe '#get' do
    let(:endpoint) { '/foo' }
    let(:query) { { foo: 'bar' } }
    let(:response) { { 'result': 'success' } }

    before do
      allow(HTTParty).to receive(:get).and_return(double(parsed_response: response))
    end

    it 'calls HTTParty.get with the correct arguments' do
      expect(HTTParty).to receive(:get).with(api_url + endpoint, { query: query, headers: api.headers })
      api.get(endpoint, query)
    end

    it 'returns the parsed response' do
      expect(api.get(endpoint, query)).to eq(response)
    end

    it 'calls validate_authorisation' do
      expect(api).to receive(:validate_authorisation)
      api.get(endpoint, query)
    end
  end
end