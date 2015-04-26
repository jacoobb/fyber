class Offer
  class << self
    def where args = {}
      page = args[:page].present? ? args[:page] : 1
      offers = Offer::ApiClient.new(page: page, pub0: args[:pub0], uid: args[:uid]).get_offers
      offers[:code] == 200 ? offers[:response]['offers'] : []
    end
  end
end