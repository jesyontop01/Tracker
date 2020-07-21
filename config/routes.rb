Rails.application.routes.draw do
 
  get 'posts/index'

  get 'posts/edit'

  resources :statuses
  resources :documents do
     resources :comments
   end

  get 'users/index'

  get 'users/show'

  devise_for :users
  root 'dashboard#index'

  resources :users , only: [] do
    member do 
      get 'api_token'
    end
  end

    #namespace :api, defaults: {format: 'json'}, path: '', constraints: {subdomain: 'api'} do
    # namespace :api do
    #     namespace :v1 do
    #       resources :users
    #       resources :documents do
    #     resources :comments
    #     end
    #   end
    # end

    namespace :api do
      namespace :v1 do
        resources :users
        resources :documents
        resources :documents do
      resources :comments
      end
      resources :users, only: [:show, :index] , param: :email do
      resources :documents do
        resources :comments
        end
      end  
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end