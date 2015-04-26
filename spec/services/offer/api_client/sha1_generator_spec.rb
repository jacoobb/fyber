require 'rails_helper'

describe Offer::DefaultParams do
  before do
    DefaultParams = Struct.new(:appid, :device_id, :locale, :ip, :offer_types)
    default_params = DefaultParams.new("appid", "device_id", "locale", "ip", "offer_types")
    allow(Offer::DefaultParams).to receive(:new).and_return(default_params)
    @params = {page: 1, pub0: 'test', uid: '1'}
  end

  it "return sha1" do
    sha1 = Digest::SHA1.hexdigest "appid=appid&device_id=device_id&ip=ip&locale=locale&offer_types=offer_types&page=#{@params[:page]}&pub0=#{@params[:pub0]}&timestamp=#{@params[:timestamp]}&uid=#{@params[:uid]}&#{Rails.application.secrets[:api]['key']}"
    expect(Offer::ApiClient::Sha1Generator.new(@params).sha1).to eq(sha1)
  end
end