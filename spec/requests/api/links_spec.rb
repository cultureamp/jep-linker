require 'rails_helper'

RSpec.describe '/api/links' do
  def json
    JSON.parse(response.body)
  end

  context 'index' do
    let!(:link) { FactoryBot.create(:link) }

    it 'returns a list of links' do
      get '/api/links'

      expect(json).to eq([
        {
          "id" => link.id,
          "short_url" => link.short_url,
          "long_url" => link.long_url,
        }
      ])
    end
  end
end
