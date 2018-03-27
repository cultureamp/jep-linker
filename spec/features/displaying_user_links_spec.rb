require 'rails_helper'
require 'pry'

RSpec.feature "links page" do
  scenario "shows all links when logged in" do
    user = FactoryBot.create(:user)
    login_as(user)
    link1 = Link.create(long_url: "www.cultureamp.com", short_url: "ca", user_id: user.id)
    link2 = Link.create(long_url: "www.juliehuang.co.nz", short_url: "jules", user_id: user.id)
    visit links_path
    expect(page).to have_content("Short_url : ca	Long_url : http://www.cultureamp.com")
  end

  scenario "does not display any links when logged out" do
    visit links_path
    expect(page).to have_content("Nothing to see here!")
  end
end
