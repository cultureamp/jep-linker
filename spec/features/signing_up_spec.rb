require 'rails_helper'

# User visits sign up route
# User enters email + password
# clicks ?
# Sees "you have signed up
RSpec.feature "signing up" do
  scenario "signs a user up with valid attributes" do
    visit new_user_registration_path
    fill_in :user_email, with: 'example@example.com'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign up"
    expect(page).to have_content("Hello, example@example.com")
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "rejects null attributes" do
    visit new_user_registration_path
    fill_in :user_email, with: ''
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_button "Sign up"
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "rejects invalid emails" do
    visit new_user_registration_path
    fill_in :user_email, with: 'garbage info'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign up"
    expect(page).to have_content("Email is invalid")
    expect(current_path).to eq(user_registration_path)
  end

  scenario "rejects sign up if password confirmation does not match password" do
    visit new_user_registration_path
    fill_in :user_email, with: 'example@example.com'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'not_jep_password'
    click_button "Sign up"
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
