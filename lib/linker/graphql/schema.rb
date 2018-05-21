module Linker
  module GraphQL
    class LinkType < ::GraphQL::Schema::Object
      graphql_name "Link"

      field :id, ID, null: false
      field :short_url, String, null: false
      field :long_url, String, null: false
    end

    class QueryType < ::GraphQL::Schema::Object
      graphql_name "Query"

      field :links, [LinkType], null: false

      def links
        Link.all
      end
    end

    class Schema < ::GraphQL::Schema
      query QueryType
    end
  end
end
