require 'rails_helper'

# User visits sign up route
# User enters email + password
# clicks ?
# Sees "you have signed up
RSpec.feature "signing up" do
  # before do
  #   @user = FactoryBot.create(:user)
  #   @user.save
  #   sign_in(@user)
  # end

  scenario "takes user to hello page if successful" do
    visit new_user_registration_path
    fill_in :user_email, with: 'example@example.com'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign up"
    expect(page).to have_content("Hello, example@example.com")
  end

  scenario "rejects invalid emails" do
    visit new_user_registration_path
    fill_in :user_email, with: 'garbage info'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'jep_password'
    click_button "Sign up"
    expect(current_path).to eq(user_registration_path)
  end

  scenario "rejects sign up if password confirmation does not match password" do
    visit new_user_registration_path
    fill_in :user_email, with: 'example@example.com'
    fill_in :user_password, with: 'jep_password'
    fill_in :user_password_confirmation, with: 'not_jep_password'
    click_button "Sign up"
    expect(current_path).to eq(user_registration_path)
  end
end
