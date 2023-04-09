Rails.application.routes.draw do
  get 'schedules/index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]
  resources :notification_settings, only: %i[new create]
end
