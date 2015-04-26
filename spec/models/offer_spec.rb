require 'rails_helper'

describe Offer do
  ResponseOffers = Struct.new(:get_offers)

  it "return table" do
    response = ResponseOffers.new({code: 200, response: {'offers' => [1,2]}})
    allow(Offer::ApiClient).to receive(:new).with(page: 1, pub0: 'test', uid: '1').and_return(response)
    expect(Offer.where({page: '', pub0: 'test', uid: '1'})).to eq([1,2])
  end

  it "return empty table" do
    response = ResponseOffers.new({code: 401, response: {'offers' => [1,2]}})
    allow(Offer::ApiClient).to receive(:new).with(page: 1, pub0: 'test', uid: '1').and_return(response)
    expect(Offer.where({page: '', pub0: 'test', uid: '1'})).to eq([])
  end
end