Rails.application.routes.draw do
  resource :offers, only: [:new, :show]
  root 'offers#new'
end
