require 'rails_helper'

RSpec.feature "Creating a custom short link" do
  subject(:custom_link) { FactoryBot.create(:custom_link) }
  let(:custom_link_attrs) { attributes_for(:custom_link) }

  let(:user) { FactoryBot.create(:user) }
  let(:user_attrs) { attributes_for(:user) }

  before do
    visit "/"
  end

  scenario "successfully creates custom short link" do
    fill_in "Long URL", with: custom_link_attrs[:long_url]
    fill_in "Custom URL", with: custom_link_attrs[:short_url]
    click_button "Shorten"
    expect(page).to have_content("Your short url is #{root_url + custom_link_attrs[:short_url]}")
  end

  scenario "shows error if short link already in use" do
    custom_link.save!
    fill_in "Long URL", with: custom_link_attrs[:long_url]
    fill_in "Custom URL", with: custom_link_attrs[:short_url]
    click_button "Shorten"
    expect(page).to have_content("Short url has already been taken")
  end

  scenario "shows error if short link is 'links'" do
    fill_in "Long URL", with: custom_link_attrs[:long_url]
    fill_in "Custom URL", with: "links"
    click_button "Shorten"
    expect(page).to have_content("Short url is invalid")
  end

  context "user is logged in" do
    before do
      login_as(user, scope: :user)
    end

    scenario "lists custom shortlink on homepage" do
      fill_in "Long URL", with: custom_link_attrs[:long_url]
      fill_in "Custom URL", with: custom_link_attrs[:short_url]
      click_button "Shorten"
      visit "/"
      expect(page).to have_content((root_url + custom_link_attrs[:short_url]).to_s)
    end

    scenario "shows error if short link already in use" do
      custom_link.save!
      fill_in "Long URL", with: custom_link_attrs[:long_url]
      fill_in "Custom URL", with: custom_link_attrs[:short_url]
      click_button "Shorten"
      expect(page).to have_content("Short url has already been taken")
    end
  end
end
