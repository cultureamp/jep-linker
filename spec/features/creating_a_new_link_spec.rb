
require 'rails_helper'

RSpec.feature "Creating a new link" do

  scenario "displays error when no link is provided" do
    visit "/"
    click_button "Create Link"
    expect(page).to have_content("Failed to save - please enter your link")
  end

  scenario "automatically generates short URL from long URL" do
    visit "/"
    fill_in 'Long URL', with: 'www.cultureamp.com'
    click_button "Create Link"
    link = Link.last
    save_and_open_page
    expect(page).to have_content("Your link is CREATED: #{link.short_url}")
  end

  scenario "returns a custom link if provided by user" do
    visit "/"
    fill_in 'Long URL', with: 'www.cultureamp.com'
    fill_in 'Short URL', with: 'abc123'
    click_button "Create Link"
    link = Link.last
    expect(page).to have_content("Your CUSTOM link is created: #{link.short_url}")
  end

  scenario "persists only unique short urls" do
    visit "/"
    fill_in 'Long URL', with: 'www.cultureamp.com'
    fill_in 'Short URL', with: 'abc123'
    click_button "Create Link"
    visit "/"
    fill_in 'Long URL', with: 'www.anotherwebsite.com'
    fill_in 'Short URL', with: 'abc123'
    click_button "Create Link"
    link = Link.last
    expect(page).to have_content("Your link could not be saved")
  end

  scenario "user is redirected to external site", js: true do
    link = Link.create(long_url: "www.juliehuang.co.nz", short_url: "jules")
    visit "#{link.short_url}"
    expect(page).to have_current_path(link.long_url)
  end
end
