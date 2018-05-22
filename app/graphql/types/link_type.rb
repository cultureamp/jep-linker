Types::LinkType = GraphQL::ObjectType.define do
  # this type is named `Link`
  name 'Link'

  # it has the following fields
  field :id, !types.ID
  field :short_url, !types.String
  field :long_url, !types.String
end
