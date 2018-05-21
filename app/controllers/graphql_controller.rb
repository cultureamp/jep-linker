require 'linker/graphql/schema'

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def run
    result = Linker::GraphQL::Schema.execute(
      query: params[:query]
    )

    render json: result
  end
end
