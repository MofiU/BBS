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
      post :close
    end
    resources :replies
  end

  resources :notes

  namespace :users do
    resources :topics
    resources :replies
    resources :notes
    resources :photos
  end


  constraints(id: /[\w\-\.]*/) do
    resources :users, path: '', as: 'users' do
      member do
        # User only
        get :topics
        get :replies
        get :favorites
        get :notes
        post :follow
        post :unfollow
        get :followers
      end
    end
  end


  match '*path', via: :all, to: 'home#error_404'
end
