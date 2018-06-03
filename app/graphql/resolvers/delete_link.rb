class Resolvers::DeleteLink < GraphQL::Function
  # arguments passed as "args"
  argument :id, types.String

  # return type from the mutation
  type Types::LinkType

  def call(_obj, args, _ctx)
    link = Link.find(args[:id])
    return unless link
    link.destroy
    link
  end
end
