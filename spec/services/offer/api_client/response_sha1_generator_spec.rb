require 'rails_helper'

describe Offer::ApiClient::ResponseSha1Generator do
  it "return sh1" do
    sha1 = Digest::SHA1.hexdigest "test#{Rails.application.secrets[:api]['key']}"
    expect(Offer::ApiClient::ResponseSha1Generator.new("test").sha1).to eq(sha1)
  end
end