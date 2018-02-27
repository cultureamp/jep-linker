require 'rails_helper'

RSpec.feature "User sign out" do
  let(:user) do
    User.create!(email: "jasmine@cultureamp.com", password: "password", password_confirmation: "password")
  end

  it "can sign out" do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    click_link "Log out"
    expect(page).to have_link("Log in")
    expect(page).to have_link("Sign up")
    expect(page).to_not have_content("Currently logged in as: #{user.email}")
  end
end
