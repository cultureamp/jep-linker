require 'rails_helper'

RSpec.feature "signing in" do
  scenario "signs a registered user in" do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Hello, #{user.email}")
  end

  scenario "does not sign an unregistered user in" do
    visit new_user_session_path
    user = { email: "email@unregistereduser.com",
             pasword: "password",
            }
    fill_in :user_email, with: user[:email]
    fill_in :user_password, with: user[:password]
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password.")
  end
end
