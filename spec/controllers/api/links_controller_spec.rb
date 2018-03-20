require 'rails_helper'

RSpec.describe Api::LinksController, type: :controller do
  describe "returns all links in json format when user is authenticated" do
    user = FactoryBot.create(:user)
    visit api_links_path
    expect(page).to have_content('{"id":1,"long_url":"elkfr","short_url":"jules","created_at":"2018-03-01T11:44:34.591Z","updated_at":"2018-03-02T05:12:23.526Z","user_id":1}')
  end

  describe "does not return any links when user is not authenticated" do
    visit_api_links_path
    expect(page).to have_content("Invalid/missing api token!")
  end
end
