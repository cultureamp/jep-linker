require 'rails_helper'

RSpec.feature "displaying links for registered users" do
  scenario "shows all links when logged in" do
    user = FactoryBot.create(:user)
    login_as = (user)
    link1 = Link.create(long_url: "www.cultureamp.com", short_url: "ca")
    link2 = Link.create(long_url: "www.juliehuang.co.nz", short_url: "jules")
    save_and_open_page
    expect(page).to have_content("link 1 = long_url: www.cultureamp.com, short_url: ca")
  end
end
