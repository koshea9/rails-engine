Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
      end
      resources :merchants, only: %i[index show] do
        get '/most_items', to: 'items#index'
          resources :items, only: [:index]
        end
      namespace :items do
        get '/find', to: 'search#show'
      end
      resources :items, only: %i[index show create update destroy] do
        resources :merchant, only: [:index], controller: 'merchants'
      end
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        get '/unshipped', to: 'invoices#index'
      end
    end
  end
end
