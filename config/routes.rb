Rails.application.routes.draw do

  # トップページ
  root 'static_pages#top'

  # 静的ページ
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'contact', to: 'static_pages#contact'

  # ユーザー登録・解答関係
  resources :users, only: %i[new create show] do
    resources :answer_forms, only: %i[create new]
  end

  # ログイン
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # パスワードリセット
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # 問題・解答フォーム
  resources :questions, only: %i[new create]
  delete 'questions/bulk_destroy', to: 'questions#bulk_destroy'

  # 問題・解答自動作成
  get 'generate', to: 'automatic_questions#generate'

  # LINEAPI
  get 'line_login_api/new', to: 'line_login_api#new'
  get 'line_login_api/login', to: 'line_login_api#login'
  get 'line_login_api/callback', to: 'line_login_api#callback'
  resources :line_users, only: %i[new create]
  post 'line_users/webhook', to: 'line_users#webhook'
  get 'line_users/line_linkage', to: 'line_users#line_linkage'
  get 'line_users/after_login_new', to: 'line_users#after_login_new'
  post 'line_users/after_login', to: 'line_users#after_login'
  get 'line_users/generate_nonce', to: 'line_users#generate_nonce'
  

  # スケジュール
  get 'schedules/index'

  # 通知
  resources :notification_settings, only: %i[new create destroy]

end
