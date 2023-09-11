Rails.application.routes.draw do
  mount_devise_token_auth_for 'Member', at: 'auth/member' ,controllers:{
    confirmations:      'auth/confirmations',
    registrations:      'auth/registrations',
    sessions:           'auth/sessions',
    passwords:          'auth/passwords',
    token_validations:  'auth/token_validations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_scope :member do
    get 'auth/member/passwords/reset'=> 'auth/passwords#reset'
  end
  namespace :api do
    get 'member/info'=> 'member#show'
    patch 'member/info' => 'member#update'
    get 'search/phone' => 'search#by_phone'
    get 'search/user_id' => 'search#by_user_id'
    resources :friend_requests ,only:[:index,:create] do
      post 'accept' => 'friend_requests#accept'
      delete 'reject' =>'friend_requests#reject'
      delete '' =>'friend_requests#destroy'
    end
    resources :friends ,only:[:index] do
      get 'check' => 'friends#check'
      patch '' => 'friends#update'
      delete '' => 'friends#destroy'
    end

    resources :chatroom, only:[:index]

    resources :groups, param: :name, only: [:show]
    resources :groups, except: [:show]
  end
end
