Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resources :users, only: [:index, :show, :create, :update, :destroy] do
      resources :artworks, only: [:index]
    end 
    resources :artworks, only: [:index, :show, :create, :update, :destroy]
    resources :artwork_shares, only: [:create, :destroy]
  end
    root 'static_pages#root'
end
