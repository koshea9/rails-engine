Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        get '/most_items', to: 'items#index'
        resources :items, only: [:index]
      end
      resources :items, only: %i[index show] do
        resources :merchant, only: [:index], controller: 'merchants'
      end
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        get '/unshipped', to: 'invoices#index'
      end
    end
  end
end
