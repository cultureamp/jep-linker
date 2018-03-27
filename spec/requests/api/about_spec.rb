require 'rails_helper'

RSpec.describe "api/about" do
  it "returns basic linker information" do
    get "/api/about"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq(
      {
        "siteName" => "linker"
      })
  end
end


