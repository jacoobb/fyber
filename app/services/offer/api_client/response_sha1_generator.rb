class Offer::ApiClient::ResponseSha1Generator
  def initialize(response)
    @response = response.to_s
  end

  def sha1
    Digest::SHA1.hexdigest @response + api_key
  end


  private 

    def api_key
      @key ||= Rails.application.secrets[:api]['key']
    end
end