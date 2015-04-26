class OffersController < ApplicationController 
  def new
    @offer_form = OfferForm.new
  end

  def show
    @offer_form = OfferForm.new offer_params
    if @offer_form.valid?
      @offers = @offer_form.offers
    else
      render :new
    end
  end


  private 

    def offer_params
      params.require(:offer_form).permit(:uid, :pub0, :page)
    end
end
