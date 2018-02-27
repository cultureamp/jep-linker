require 'rails_helper'

RSpec.feature "New user sign up" do
  let(:valid_email) { "jasmine@cultureamp.com" }
  let(:valid_password) { "password" }
  let(:invalid_password) { "boop" }

  context "using valid credentials" do
    it "can sign up" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path(new_user_registration_path)
      fill_in "user_email", with: valid_email
      fill_in "user_password", with: valid_password
      fill_in "user_password_confirmation", with: valid_password
      click_button "Sign up"
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Currently logged in as: #{valid_email}")
    end
  end

  context "password is less than 6 characters" do
    it "cannot sign up" do
      visit new_user_registration_path
      fill_in "user_email", with: valid_email
      fill_in "user_password", with: invalid_password
      fill_in "user_password_confirmation", with: invalid_password
      click_button "Sign up"
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
  end

  context "password and password confirmation do not match" do
    it "cannot sign up" do
      visit new_user_registration_path
      fill_in "user_email", with: valid_email
      fill_in "user_password", with: invalid_password
      fill_in "user_password_confirmation", with: "panda"
      click_button "Sign up"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
