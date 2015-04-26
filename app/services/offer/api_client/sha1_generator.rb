class Offer::ApiClient::Sha1Generator
  def initialize(args)
    @page = args[:page]
    @pub0 = args[:pub0]
    @uid = args[:uid]
    @timestamp = args[:timestamp]
    @dp = Offer::DefaultParams.new
  end

  def sha1
    params = "appid=#{@dp.appid}&device_id=#{@dp.device_id}&ip=#{@dp.ip}&locale=#{@dp.locale}&offer_types=#{@dp.offer_types}&page=#{@page}&pub0=#{@pub0}&timestamp=#{@timestamp}&uid=#{@uid}&#{api_key}"
    Digest::SHA1.hexdigest params
  end


  private 

    def api_key
      @key ||= Rails.application.secrets[:api]['key']
    end
end