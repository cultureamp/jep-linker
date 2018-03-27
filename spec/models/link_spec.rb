require 'rails_helper'

RSpec.describe Link, type: :model do
  subject { described_class.new }
  it "is valid with valid attributes" do
    subject.long_url = "https://www.sdjskdskdjskdjskdjskdjskdjskdjskdmxsdskjdskd.com"
    subject.short_url = "ssd2233"
    expect(subject).to be_valid
  end

  it "is not valid with no attributes" do
    subject.long_url = nil
    expect(subject).to_not be_valid
  end
end
