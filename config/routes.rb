Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :exchanges, only: [:index, :new, :create, :edit, :update]
  end

  resources :exchanges, only: [:show] do
    resources :participations, only: [:new, :show, :edit, :create, :update]
  end
end
