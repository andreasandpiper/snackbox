Rails.application.routes.draw do
  root 'exchanges#index'

  namespace :admin do
    resources :exchanges, only: [:index, :new, :create, :edit, :update, :show]
  end

  resources :exchanges, only: [:show, :index] do
    resources :participations, only: [:new, :show, :edit, :create, :update]
  end
end
