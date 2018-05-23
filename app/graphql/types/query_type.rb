Types::QueryType = GraphQL::ObjectType.define do
  name "linkQuery"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # queries are just represented as fields
  field :allLinks, !types[Types::LinkType] do
    # resolve would be called in order to fetch data for that field
    resolve -> (obj, args, ctx) { Link.where(user: ctx[:current_user]) }
  end

  field :link, Types::LinkType do
    argument :shortUrl, !types.String
    resolve -> (obj, args, ctx) { Link.find_by(short_url: args["shortUrl"], user: ctx[:current_user]) }
  end
end
