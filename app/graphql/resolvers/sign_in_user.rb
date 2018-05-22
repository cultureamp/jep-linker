class Resolvers::SignInUser < GraphQL::Function
  argument :email, !types.String
  argument :token, !types.String

  type do
    name 'SigninPayload'

    field :session_token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, _ctx)
    email = args[:email]
    token = args[:token]

    # basic validation
    return unless email
    return unless token

    user = User.find_by(email: email, token: token)

    # ensures we have the correct user
    return unless user

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    session_token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    OpenStruct.new({
      user: user,
      session_token: session_token
    })
  end
end
