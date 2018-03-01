require 'rails_helper'

RSpec.feature "signing in" do
  scenario "signs a registered user in" do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button "Log in"
    expect(sign_in(user))
    expect(page).to have_content("Hello, #{user.email}")
  end
end
