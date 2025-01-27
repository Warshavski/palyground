# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # @see AboutController
  root to: 'about#show', defaults: { format: 'json' }
  resources :genres, only: [:index, :show]
end
