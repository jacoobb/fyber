class Offer::DefaultParams
  def appid
    @appid ||= Rails.application.secrets[:default_params]['appid']
  end

  def device_id
    @device_id ||= Rails.application.secrets[:default_params]['device_id']
  end

  def locale
    @locale ||= Rails.application.secrets[:default_params]['locale']
  end

  def ip
    @ip ||= Rails.application.secrets[:default_params]['ip']
  end

  def offer_types
    @offer_types ||= Rails.application.secrets[:default_params]['offer_types']
  end
end