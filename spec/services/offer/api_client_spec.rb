require 'rails_helper'

describe Offer::ApiClient do
  Response = Struct.new(:code, :body)
  before{@params = {page: 1, pub0: 'test', uid: '1'}}

  describe 'get_offers' do
    describe "succes valid signature" do

      before do
        allow_any_instance_of(Offer::ApiClient).to receive(:response_signature_valid?).and_return(true)
        response = Response.new('201', 'test')
        allow(JSON).to receive(:parse).and_return('test')
        allow_any_instance_of(Offer::ApiClient).to receive(:call).and_return(response)
      end

      it "return value" do
        client = Offer::ApiClient.new(@params)
        expect(client.get_offers).to eq({code: '201', response: 'test'})
      end

    end

    describe "error valid signature" do

      before do
        allow_any_instance_of(Offer::ApiClient).to receive(:response_signature_valid?).and_return(false)
        response = Response.new('201', 'test2')
        allow(JSON).to receive(:parse).and_return('test2')
        allow_any_instance_of(Offer::ApiClient).to receive(:call).and_return(response)
      end

      it "return value" do
        client = Offer::ApiClient.new(@params)
        expect(client.get_offers).to eq({code: false, response: 'test2'})
      end

    end
  end
  
  describe 'call' do 

    before do
      DefaultParamsStruct = Struct.new(:appid, :device_id, :locale, :ip, :offer_types)
      default_params = DefaultParamsStruct.new("appid", "device_id", "locale", "ip", "offer_types")
      allow(Offer::DefaultParams).to receive(:new).and_return(default_params)
    end

    before do
      @current_time = DateTime.current
      allow(DateTime).to receive(:current).and_return(@current_time)
      Sha1 = Struct.new(:sha1)
      sha1 = Sha1.new('sha1')
      allow(Offer::ApiClient::Sha1Generator).to receive(:new).with(page: 1, pub0: 'test', uid: '1', timestamp: @current_time.to_time.to_i).and_return(sha1)
    end

    it "send get" do
      client = Offer::ApiClient.new(@params)
      allow(RestClient).to receive(:get).with(Rails.application.secrets[:api]['host'],{
        params: {
          appid: "appid",
          device_id: "device_id",
          ip: "ip",
          locale: "locale",
          offer_types: "offer_types",
          page: @params[:page],
          pub0: @params[:pub0],
          timestamp: @current_time.to_time.to_i,
          uid: @params[:uid],
          hashkey: 'sha1'
        }
        })
      client.send(:call)
    end
  end
end