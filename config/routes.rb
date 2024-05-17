Rails.application.routes.draw do
  root "spend_forecasts#index"
  resources :spend_forecasts
end
