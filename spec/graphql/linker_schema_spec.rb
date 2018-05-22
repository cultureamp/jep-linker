require 'rails_helper'

describe LinkerSchema do
  let(:user) { User.create!(email: "some@email.com", password: "password") }
  let!(:existing_link) { Link.create!(short_url: "abc123", long_url: "http://www.google.com", user: user) }

  it "fetches all the links" do
    query = %|
      query {
        allLinks {
          id
          long_url
          short_url
        }
      }
    |

    result = LinkerSchema.execute(
      query: query
    )

    links = result.dig("data", "allLinks")
    expect(links.count).to eq(1)

    link = links.first
    expect(link["id"]).to eq(existing_link.id.to_s)
    expect(link["short_url"]).to eq(existing_link.short_url)
    expect(link["long_url"]).to eq(existing_link.long_url)
  end

  it 'fetches single link by short URL' do
    query = %|
      query linkQuery {
        link(shortUrl: "abc123") {
          long_url
        }
      }
    |

    result = LinkerSchema.execute(
      query: query
    )

    link = result.dig("data", "link")
    expect(link["long_url"]).to eq(existing_link.long_url)
  end
end
