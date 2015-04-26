require "addressable/uri"

class Offer::ApiClient
  def initialize(args = {})
    @page = args[:page]
    @pub0 = args[:pub0]
    @uid = args[:uid]
    @dp = Offer::DefaultParams.new
  end

  def get_offers
    response = call
    return {code: false, response: JSON.parse(response.body)} unless response_signature_valid?(response)
    {code: response.code, response: JSON.parse(response.body)}
  end
  
  
  private
    
    def response_signature_valid? response
      response_sha1 = Offer::ApiClient::ResponseSha1Generator.new(response).sha1
      response_sha1 == response.headers[:x_sponsorpay_response_signature]
    end

    def call
      sha1 = Offer::ApiClient::Sha1Generator.new(page: @page, pub0: @pub0, uid: @uid, timestamp: timestamp).sha1
      begin
        RestClient.get host, {params: {
          appid: @dp.appid,
          device_id: @dp.device_id,
          ip: @dp.ip,
          locale: @dp.locale,
          offer_types: @dp.offer_types,
          page: @page,
          pub0: @pub0,
          timestamp: timestamp,
          uid: @uid,
          hashkey: sha1}}
      rescue => e
        e.response
      end
    end

    def timestamp
      @timestamp ||= DateTime.current.to_time.to_i
    end

    def host
      @host ||= Rails.application.secrets[:api]['host']
    end
end