require 'rails_helper'

RSpec.describe '/api/links' do
  def json
    JSON.parse(response.body)
  end

  context 'index' do
    context 'as an authenticated user' do
      let!(:user) { FactoryBot.create(:user, :with_token) }
      let(:headers) do
        {
          'HTTP_AUTHORIZATION' => "Bearer #{user.token}"
        }
      end

      let!(:link) { FactoryBot.create(:link, user: user) }

      it 'returns a list of links' do
        get '/api/links', headers: headers

        expect(json).to eq([
          {
            "id" => link.id,
            "short_url" => link.short_url,
            "long_url" => link.long_url,
          }
        ])
      end
    end

    context 'as an unauthenticated user' do
      it 'is unauthorized to see that page' do
        get '/api/links'
        expect(response.status).to eq(401)
        expect(json).to eq({ "error" => "Unauthenticated." })
      end
    end
  end
end
