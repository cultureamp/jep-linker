
require 'rails_helper'

#  TESTING PLAN

#  FEATURE TEST 1) displays validation error message if there is no URL specified in field

#  FEATURE TEST 2) returns short URL from long URL
#  - F2 UNIT TEST: Check if long URL already exists in database
#  - F2 UNIT TEST: Generate short url if not
#  - F2 UNIT TEST: Ensures no two URLs have the same `short_link` value in database

#  FEATURE TEST 3) re-directs user to long  URL from short URL

#  FEATURE TEST 4) can generate a custom short URL if user requests
#  - F4 UNIT TEST: Generates a short URL automatically when custom field blank
#  - F4 UNIT TEST: Generates a short URL with custom link if custom field populated
#  - F4 UNIT TEST: Generates flash error if custom short URL already exists
#  - F4 UNIT TEST: Form fields stay populated with entered values

#  FEATURE TEST 5) Validates long URLs to be working URLs

#  FEATUE TEST 6) Validates that other short-link services are NOT being permitted in database


RSpec.feature "Creating a new link" do
  scenario "displays error when no link is provided" do
    visit "/"
    click_button "Create Link"
    expect(page).to have_content("Failed to save - please enter your link")
  end

  scenario "returns a short link if it already exists" do
    long_url = "www.juliehuang.co.nz"
    link = Link.create(short_url: "jules", long_url: long_url)
    visit "/"
    fill_in 'Long URL', with: long_url
    click_button "Create Link"
    expect(page).to have_content("Your link ALREADY EXISTS and is #{link.short_url}")
  end

  scenario "automatically generates short URL from long URL" do
    visit "/"
    fill_in 'Long URL', with: 'www.cultureamp.com'
    click_button "Create Link"
    link = Link.last
    expect(page).not_to have_content("Your link is CREATED: 0")
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
    short_url = "abc123"
    link = Link.create(short_url: short_url )
    visit "/"
    fill_in 'Long URL', with: 'www.anotherwebsite.com'
    fill_in 'Short URL', with: short_url
    click_button "Create Link"
    expect(page).to have_content("Your link could not be saved")
    expect(page).to have_content("Short url has already been taken")
  end
end
