require 'rails_helper'

RSpec.feature "Visiting a short link" do
  let(:custom_link) { FactoryBot.create(:custom_link) }
  let(:custom_link_attrs) { attributes_for(:custom_link) }

  scenario "user is redirected to external site", js: true do
    visit "/"
    fill_in "Long URL", with: custom_link_attrs[:long_url]
    fill_in "Custom URL", with: custom_link_attrs[:short_url]
    click_button "Shorten"
    visit "/#{custom_link_attrs[:short_url]}"
    expect(current_url).to eq(custom_link_attrs[:long_url])
  end
end
