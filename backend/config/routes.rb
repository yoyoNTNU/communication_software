Rails.application.routes.draw do
    mount_devise_token_auth_for 'Member', at: 'auth/member' ,controllers:{
      confirmations: 'auth/confirmations',
    }
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    namespace :api do
      get 'member/info'=> 'member#show'
      patch 'member/info' => 'member#update'

    end
    # Defines the root path route ("/")
    # root "articles#index"
end
