Types::MutationType = GraphQL::ObjectType.define do
  name "linkMutation"

  field :createUser, function: Resolvers::CreateUser.new
  field :signinUser, function: Resolvers::SignInUser.new
  field :createLink, function: Resolvers::CreateLink.new
  field :deleteLink, function: Resolvers::DeleteLink.new
end
