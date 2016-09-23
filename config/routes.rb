Rails.application.routes.draw do

  root 'home#index'
  namespace :home do
    get 'error_404'
    get 'error_500'
  end


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    # omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }


  resources :topics do
    member do
      post :reply
      post :favorite
      delete :unfavorite
      post :follow
      delete :unfollow
      post :close
      post :like
      delete :unlike
    end
    collection do
      get 'favorites'
      get 'creams'
    end
    resources :replies
  end

  resources :notes
  resources :users
  resources :replies do
    member do
      post 'like'
      delete 'unlike'
    end
  end

  resources :notifications

  namespace :users do
    scope ':id' do
      resources :topics
      resources :replies
      resources :notes
      resources :photos
      get 'favorites'
      get 'followers'
      get 'following'
      get 'calendar'
      post 'follow'
      post 'unfollow'
      post 'block'
      post 'unblock'
      post 'grant_user'
      post 'grant_admin'
    end
  end





  match '*path', via: :all, to: 'home#error_404'
end
