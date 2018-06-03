require 'rails_helper'

describe Resolvers::CreateLink do
  let(:user) { User.create!(email: "some@email.com", password: "password") }

  it 'creates a new link' do
    link = perform(long_url: "someurl.com", short_url: "abc123")
    expect(link["short_url"]).to eq("abc123")
    expect(link["long_url"]).to eq("someurl.com")
  end

  context 'no short URL provided' do
    it 'creates a new link with generated short url' do
      link = perform(long_url: "someurl.com")
      expect(link["long_url"]).to eq("someurl.com")
      expect(link["short_url"]).to_not be_blank
    end
  end

  def perform(args = {})
    described_class.new.call(nil, args, { current_user: user })
  end
end
