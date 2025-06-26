# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    collection do
      get "clear_completed"
    end
  end

  root to: "tasks#index"
end
