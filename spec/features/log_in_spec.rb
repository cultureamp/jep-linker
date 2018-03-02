require 'rails_helper'
require 'capybara/dsl'

RSpec.feature "Logginf in" do
  let(:user) { FactoryBot.create(:user) }
  before do
    visit new_user_registration_path
  end
  scenario "successfully sign up" do
    fill_in "user_email", with: "jaime@something.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
    expect(User.find_by(email: "jaime@something.com")).not_to be_nil
    expect(page).to have_current_path("/")
  end
  scenario "successfully sign in" do
    user.save!
    visit "/users/sign_in"
    fill_in "user_email", with: "test@example.com" 
    fill_in "user_password", with: "f4k3p455w0rd"
    click_button "Log in"
    expect(page).to have_current_path("/")
  end
end
