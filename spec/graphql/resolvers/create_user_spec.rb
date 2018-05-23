require 'rails_helper'

describe Resolvers::CreateUser do
  it 'creates a new user' do
    user = perform(
      authProvider: {
        email: {
          email: 'email@example.com',
          password: 'password'
        }
      }
    )

    expect(user["email"]).to eq("email@example.com")
  end

  def perform(args = {})
    described_class.new.call(nil, args, nil)
  end
end
