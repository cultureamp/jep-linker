require 'rails_helper'

RSpec.feature "Creating a new link" do
  let(:link) { FactoryBot.create(:link) }
  let(:link_attrs) { attributes_for(:link) }

  let(:custom_link) { FactoryBot.create(:custom_link) }
  let(:custom_link_attrs) { attributes_for(:custom_link) }

  let(:user) { FactoryBot.create(:user) }
  let(:user_attrs) { attributes_for(:user) }

  before do
    visit "/"
  end

  scenario "successfully creates a new link" do
    fill_in "Long URL", with: link_attrs[:long_url]
    click_button "Shorten"
    link = Link.last
    expect(page).to have_content("Your short url is #{root_url + link.short_url}")
  end

  context "long_url is taken" do
    scenario "shows taken link if short_url is not custom" do
      fill_in "Long URL", with: link_attrs[:long_url]
      click_button "Shorten"
      taken_link = Link.last
      visit "/"
      fill_in "Long URL", with: taken_link.long_url
      click_button "Shorten"
      expect(page).to have_content("Your short url is #{root_url + taken_link.short_url}")
    end

    scenario "generates new link if taken link is custom" do
      custom_link.save!
      fill_in "Long URL", with: custom_link_attrs[:long_url]
      click_button "Shorten"
      new_link = Link.last
      expect(page).to have_content("Your short url is #{root_url + new_link.short_url}")
    end
  end

  scenario "shows error message if no link submitted" do
    click_button "Shorten"
    expect(page).to have_content("Long url can't be blank")
  end

  scenario "shows an error message if long url is invalid" do
    fill_in "Long URL", with: "leftover Christmas ham"
    click_button "Shorten"
    expect(page).to have_content("Invalid URL format")
  end

  context "using another shortening service" do
    let(:error_message) { "shortening service not allowed in long URL" }

    scenario "google shortening not allowed" do
      fill_in "Long URL", with: "https://goo.gl/5PnQ4y"
      click_button "Shorten"
      expect(page).to have_content(error_message)
    end

    scenario "bit.ly is not allowed" do
      fill_in "Long URL", with: "http://bit.ly/2oG0C3v"
      click_button "Shorten"
      expect(page).to have_content(error_message)
    end
  end

  context "user is logged in" do
    before { login_as(user, scope: :user) }

    scenario "can view list of links they created on homepage" do
      fill_in "Long URL", with: link_attrs[:long_url]
      click_button "Shorten"
      link = Link.last
      visit root_path
      expect(page).to have_content((root_url + link.short_url).to_s)
    end

    scenario "long_url is taken, generates new link anyway" do
      link.save!
      fill_in "Long URL", with: link_attrs[:long_url]
      click_button "Shorten"
      link = Link.last
      visit root_path
      expect(page).to have_content((root_url + link.short_url).to_s)
    end
  end
end
