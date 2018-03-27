require 'rails_helper'

RSpec.feature "signing out" do
  scenario "signs a user out" do
    user = FactoryBot.create(:user)
    login_as(user)
    visit root_path
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.")
  end
end
