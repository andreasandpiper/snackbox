# frozen_string_literal: true

Rails.application.routes.draw do
  root 'exchanges#index'

  namespace :admin do
    resources :exchanges, only: %i[index new create edit update show]
    get 'exchange/:id/match', to: 'exchanges#match'
    post 'exchange/:id/set_view', to: 'exchanges#match_is_viewable'
  end

  resources :exchanges, only: %i[show index] do
    resources :participations, only: %i[new edit create update destroy]
    get '/link', to: 'participations#edit_link'
  end
end
