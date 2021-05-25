# frozen_string_literal: true

Rails.application.routes.draw do
  root 'exchanges#index'

  namespace :admin do
    resources :exchanges, only: %i[index new create edit update show]
    get 'exchanges/:id/match', to: 'exchanges#match'
    get 'exchanges/:id/deliver_matches', to: 'exchanges#deliver_matches'
    get 'exchanges/:id/send_reminder', to: 'exchanges#send_reminder'
    get 'exchanges/:id/send_ship_reminder', to: 'exchanges#send_ship_reminder'
    post 'exchanges/:id/participations/:participation_id/exclude', to: 'exchanges#set_exclude'
  end

  resources :exchanges, only: %i[show index] do
    resources :participations, only: %i[new edit create update destroy]
    get '/link', to: 'participations#edit_link'
    get '/participations/:id/verify', to: 'participations#verify'
    get '/participations/:id/ship', to: 'participations#ship'
  end
end
