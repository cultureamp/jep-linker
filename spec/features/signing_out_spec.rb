require 'rails_helper'

RSpec.feature "User sign out" do
  subject(:user) { FactoryBot.create(:user) }
  let(:attrs) { attributes_for(:user) }

  before do
    login_as(user, scope: :user)
  end

  context "when logged in" do
    it "can sign out" do
      visit "/"
      click_link "Log out"
      expect(page).to have_link("Log in")
      expect(page).to have_link("Sign up")
      expect(page).to_not have_content("Currently logged in as: #{attrs[:email]}")
    end
  end
end
