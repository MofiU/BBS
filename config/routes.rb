Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    # omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    conformations: 'users/conformations',
    unlocks: 'users/unlocks'
  }


  resources :topics do
    member do
      post :reply
      post :favorite
      delete :unfavorite
      post :follow
      delete :unfollow
    end
    resources :replies
  end

  namespace :users do
    resources :topics
    resources :replies
    resources :notes
    resources :photos
  end

  match '*path', via: :all, to: 'home#index'
end
