Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
root to: 'homes#top'
get "search" => "searches#search"
resources :customers, only: [:index,:show,:edit,:update] do
  get 'order_index' => 'customers#order_index'
end
resources :items
resources :genres, except: [:new, :show]
resources :orders, only: [:show, :update]
resources :order_details, only: [:update]
end

 root to: 'public/homes#top'
 get 'about' =>'public/homes#about'
 get "search" => "public/searches#search"

 scope module: :public do
 resources :addresses
 get "/customers/mypage" => "customers#show"
 get "/customers/edit" => "customers#edit"
 resources :customers #, except: [:show]

 # 退会確認画面＆論理削除用のルーティング
 get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
 patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'

 resources :items, only: [:index, :show]
 resources :orders, only: [:new, :create, :index, :show] do
 collection do
 post 'comfirm' => 'orders#comfirm'
 get 'complete' => 'orders#complete'
 end
 end
 resources :cart_items, only: [:index, :create, :destroy, :update,] do
 collection do
 delete 'destroy_all' => 'cart_items#destroy_all'
 end
 end
 end
end