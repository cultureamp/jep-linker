class Resolvers::CreateLink < GraphQL::Function
  # arguments passed as "args"
  argument :short_url, types.String
  argument :long_url, !types.String

  # return type from the mutation
  type Types::LinkType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, ctx)
    Link.create!(
      short_url: args[:short_url],
      long_url: args[:long_url],
      user: ctx[:current_user]
    )
  end
end
