require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:long_url) { "http://google.com" }
  it "can create a link successfully" do
    post :create, params: { link: { long_url: long_url } }
    link = Link.find_by(long_url: long_url)
    expect(link).to be_present
    expect(response).to redirect_to(link_path(link))
  end

  it "shows a link" do
    post :create, params: { link: { long_url: long_url } }
    link = Link.find_by(long_url: long_url)
    get :show, params: { id: link.id }
    expect(response).to be_success
  end

  it "forwards a short url to long url" do
    link = Link.create(long_url: long_url)
    get :forward, params: { short_url: link.short_url }
    expect(response).to redirect_to(long_url)
  end

  it "formats long urls" do
    post :create, params: { link: { long_url: "www.google.com" } }
    link = Link.find_by(long_url: long_url)
    expect(link).to be_present
    expect(link.long_url).to eq("http://google.com")
  end
end
