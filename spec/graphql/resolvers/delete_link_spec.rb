require 'rails_helper'

describe Resolvers::DeleteLink do
  let(:user) { User.create!(email: "user@email.com", password: "password") }
  let!(:link) { Link.create!(long_url: "link.com", user: user) }

  it 'deletes link' do
    perform(id: link.id)
    expect(Link.count).to eq(0)
  end

  def perform(args = {})
    described_class.new.call(nil, args, nil)
  end
end
