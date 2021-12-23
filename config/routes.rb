Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/create'
  
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  
  root to: "tasks#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  
  resources :tasks
  resources :users, only: [:index, :show, :new, :create]
end

# CRUD Create,Read,Update,Delete のルーティング
  # get "tasks/:id", to: "tasks#show" 詳細ページの表示
  # post "tasks", to: "tasks#create" 保存アクション
  # put "tasks/:id", to: "tasks#update" 更新アクション
  # delete "tasks/:id", to: "tasks#destroy" 削除アクション
  
  # get "tasks", to: "tasks#index" 詳細ページ(show)へアクセスするための一覧ページ(index)
  # get "tasks/new", to: "tasks#new" 保存アクション(create)にデータを送るための新規作成用フォームページ(new)
  # get "tasks/:id/edit", to: "tasks#edit" 更新アクション(update)にデータを送るための編集用フォームページ(edit)