require 'rails_helper'

describe Resolvers::SignInUser do
  let!(:user) { User.create!(email: "some@email.com", password: "password") }

  it 'signs in user' do
    result = perform(
      email: "some@email.com",
      password: "password"
    )
    signed_in_user = result["user"]
    expect(signed_in_user["email"]).to eq(user.email)
  end

  def perform(args = {})
    described_class.new.call(nil, args, {})
  end
end
