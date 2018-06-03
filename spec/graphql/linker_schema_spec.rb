require 'rails_helper'

describe LinkerSchema do
  let!(:user) { User.create!(email: "some@email.com", password: "password") }
  let!(:other_user) { User.create!(email: "other@email.com", password: "password") }
  let!(:first_link) { Link.create!(short_url: "abc123", long_url: "http://www.google.com", user: user) }
  let!(:second_link) { Link.create!(short_url: "other", long_url: "http://www.other.com", user: other_user) }

  it "fetches all the links for the user" do
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
      query: query,
      context: { current_user: user }
    )

    links = result.dig("data", "allLinks")
    expect(links.count).to eq(1)

    link = links.first
    expect(link["id"]).to eq(first_link.id.to_s)
    expect(link["short_url"]).to eq(first_link.short_url)
    expect(link["long_url"]).to eq(first_link.long_url)
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
      query: query,
      context: { current_user: user }
    )

    link = result.dig("data", "link")
    expect(link["long_url"]).to eq(first_link.long_url)
  end

  it 'creates a user' do
    mutation = %|
      mutation {
        createUser(
          authProvider: {
            email: {
              email: "user@test.com",
              password: "password"
            }
          }
        ) {
          email
        }
      }
    |

    result = LinkerSchema.execute(query: mutation)
    user = result.dig("data", "createUser")
    expect(user["email"]).to eq("user@test.com")
  end

  it 'signs in a user' do
    mutation = %|
      mutation {
        signinUser(
          email: "some@email.com",
          password: "password"
        ) {
          token
          user {
            email
          }
        }
      }
    |

    result = LinkerSchema.execute(query: mutation)
    user = result.dig("data", "signinUser", "user")
    expect(user["email"]).to eq("some@email.com")
  end
end
