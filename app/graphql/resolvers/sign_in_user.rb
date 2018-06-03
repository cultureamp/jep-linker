require 'SecureRandom'

class Resolvers::SignInUser < GraphQL::Function
  argument :email, !types.String
  argument :password, !types.String

  # defines inline return type for the mutation
  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, _ctx)
    email = args[:email]
    password = args[:password]

    return unless email && password
    user = User.find_by(email: email)

    return unless user
    return unless user.valid_password?(password)

    token = SecureRandom.hex(16)
    user.update_attributes(token: token)

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end
