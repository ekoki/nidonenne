Rails.application.routes.draw do
  get 'questions/new'
  get 'schedules/index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  resources :users, only: %i[new create show]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]
  resources :notification_settings, only: %i[new create]
  resources :questions, only: %i[new create]
  resources :answer_forms, only: %i[create new]
  post 'webhook', to: 'line_users#webhook'
  get 'line_users/new', to: 'line_users#new'
  get 'line_login_api/login', to: 'line_login_api#login'
  get 'line_login_api/callback', to: 'line_login_api#callback'
end
