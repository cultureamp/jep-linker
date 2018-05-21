require 'rails_helper'
require 'linker/graphql/schema'

describe Linker::GraphQL::Schema do
  let(:user) { User.create!(email: "some@email.com", password: "password") }
  let!(:existing_link) { Link.create!(short_url: "abc123", long_url: "http://www.google.com", user: user) }

  it "fetches all the links" do
    query = %|
      query allLinks {
        links {
          id
          shortUrl
          longUrl
        }
      }
    |

    result = Linker::GraphQL::Schema.execute(
      query: query
    )

    links = result.dig("data", "links")
    expect(links.count).to eq(1)

    link = links.first
    expect(link["id"]).to eq(existing_link.id.to_s)
    expect(link["shortUrl"]).to eq(existing_link.short_url)
    expect(link["longUrl"]).to eq(existing_link.long_url)
  end
end
