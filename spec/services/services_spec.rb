require 'spec_helper'

RSpec.describe Services::Url do
  long_url = "http://www.ryanbigg.com"
  short_url = "xXx"
  empty_short_url = ""
  link_params = {long_url: long_url, short_url: empty_short_url}
  before(:each) do
    @url_shortener = described_class
    url = "www.google.com"
    @shortened_url = @url_shortener.set_url(url: url)
  end

  describe "Url" do
    context "given a long url" do
      it "provides a shorter URL" do
        url_length = link_params[:long_url].length
        expect(@url_shortener.find_or_create(link_params).short_url.length).to be < url_length
      end
    end

    describe "set_url" do
      it "adds http scheme to user input" do
        expect(@shortened_url.scheme).to eq("http")
      end

      it "includes hostname in shortened url" do
        expect(@shortened_url.host).to eq('www.google.com')
      end

      it "has no path is none is entered" do
        expect(@shortened_url.path).to eq('')
      end
    end

    context "given a short url" do
      it "checks to see if it already exists" do
        expect(@url_shortener.custom_url(long_url: long_url, short_url: short_url).short_url).to eq("xXx")
      end
    end
  end
end
