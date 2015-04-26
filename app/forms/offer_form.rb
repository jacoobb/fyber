class OfferForm
  include ActiveModel::Model

  attr_reader :uid, :pub0, :page

  validates :uid, presence: true
  validates :page, numericality: { only_integer: true, greater_than: 0 }, if: "page.present?"

  def initialize args = nil
    @uid, @pub0, @page = args[:uid], args[:pub0], args[:page] if args.present?
  end

  def offers
    Offer.where(page: @page, pub0: @pub0, uid: @uid)
  end
  
end