require 'spec_helper'

RSpec.feature "Creating a custom short link" do
  let(:long_url) { "https://ryanbigg.com/2016/04/hiring-juniors" }
  let(:custom_url) { "juniors" }

  it "successfully creates custom short link" do
    visit "/"
    fill_in "Long URL", with: long_url
    fill_in "Custom URL", with: "juniors"
    click_button "Shorten"
    expect(page).to have_content("Your short url is #{root_url + custom_url}")
  end

  it "shows error if short link already in use" do
    Link.create!(long_url: long_url, short_url: custom_url)
    visit "/"
    fill_in "Long URL", with: long_url
    fill_in "Custom URL", with: custom_url
    click_button "Shorten"
    expect(page).to have_content("Short url has already been taken")
  end

  it "shows error if short link is 'links'" do
    visit "/"
    fill_in "Long URL", with: long_url
    fill_in "Custom URL", with: "links"
    click_button "Shorten"
    expect(page).to have_content("Short url is invalid")
  end
end
