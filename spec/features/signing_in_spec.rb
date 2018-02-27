require 'rails_helper'

RSpec.feature "User sign in" do
  let(:user) do
    User.create!(email: "jasmine@cultureamp.com", password: "password", password_confirmation: "password")
  end

  context "when the user exists" do
    it "can sign in" do
      visit root_path
      click_link "Log in"
      expect(page).to have_current_path(new_user_session_path)
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Currently logged in as: #{user.email}")
    end
  end

  context "when the user doesn't exist" do
    let(:email) { "foo@example.com" }

    it "can't sign in" do
      visit new_user_session_path
      fill_in "user_email", with: email
      fill_in "user_password", with: "password1"
      click_button "Log in"
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to_not have_content("Currently logged in as: #{email}")
    end
  end

  context "the password is incorrect" do
    it "cannot sign in" do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "pandas"
      click_button "Log in"
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to_not have_content("Currently logged in as: #{user.email}")
    end
  end
end
