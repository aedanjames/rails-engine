Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get '/merchants/find', to: 'merchants_search#find'
      get '/merchants/find_all', to: 'merchants_search#find_all'
      get '/items/find_all', to: 'items_search#find_all'
      get '/items/find', to: 'items_search#find'
      get '/merchants/most_items', to: 'merchants#most_items'
      resources :items, only: [:index, :show, :create, :destroy, :update] 

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end 
      
      resources :items do 
        resources :merchant, only: [:index], controller: :item_merchant
      end 
# activerecord exercise begin
      namespace :revenue do 
        resources :merchants, only: [:index, :show]
        resources :items, only: [:index]
      end 
      # namespace :revenue, only: [:index]
    end
  end 
end