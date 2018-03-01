require 'rails_helper'

# User visits sign up route
# User enters email + password
# clicks ?
# Sees "you have signed up
RSpec.feature "signing up" do
  scenario "signs up" do
    visit "/etcetcetc"
    click_button "_"
    visit new_user_registration_path
    fill_in :user_email, with: 'example@example.com'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign Up"
    expect(page).to have_content("Hello, example@example.com")
  end

  scenario "rejects invalid emails" do
    visit "/etcetcetc"
    click_button "_"
    fill_in :user_email, with: 'garbage info'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign Up"
    expect(page).to have_content("invalid email, please try again")
  end
end
