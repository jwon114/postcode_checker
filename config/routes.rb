Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'postcode_checker#index', as: 'postcode_checker'
  post '/check', to: 'postcode_checker#check', as: 'postcode_checker_check'
  resources :whitelisted_postcodes, only: [:index, :create, :destroy]
end
