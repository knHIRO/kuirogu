Rails.application.routes.draw do
  namespace :public do
    get "relationships/followings"
    get "relationships/followers"
  end
  get "relationships/followings"
  get "relationships/followers"
  #namespace :admin do

  #end
  #namespace :public do

  #end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
}
root to: "public/homes#top"


devise_scope :customer do
    post "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
end

get "public" => "public/homes#about", as: "about"
get "search" => "public/postings#search"
patch "public/customers/exit" => "public/customers#quit", as: "customers_exit"
namespace :public do
    get "/.env", to: "errors#not_found"
    post "/", to: "controller#action"
post "/homes/guest_sign_in", to: "homes#guest_sign_in"
  get "favorites" => "customers#favorites" #, as: 'about'
  resources :maps, only: [:index]
 resources :customers, only:[:show, :index, :edit, :update] do
  get :search, on: :collection
  resource :relationships, only: [:create, :destroy]
    get "followings" => "public/relationships#followings", as: "followings"
    get "followers" => "public/relationships#followers", as: "followers"
 end
 resources :postings, only: [:new, :create, :index, :show, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
 end
 resources :notifications, only:[:index]
 #resources :notices, only:[:index]
 #resources :posts, only: [:show]
end


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}



get "admin" => "admin/homes#top"
namespace :admin do
 resources :customers, only: [:show, :edit, :update]
 resources :postings, only: [:show, :destroy] do
  #resources :post_comments, only: [:create, :destroy]
 end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
