Rails.application.routes.draw do
  namespace :admin do

  end
  namespace :public do

  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
root to: "public/homes#top"
get 'public' => 'public/homes#about', as: 'about'
namespace :public do
 resource :customers, only:[:show, :edit, :update]
 resources :postings, only: [:new, :index, :show, :create, :destroy]
 resources :greats, only:[:index]
 resources :notices, only:[:index]
end
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

get 'admin' => 'admin/homes#top'
namespace :admin do
 resources :customers, only: [:show, :edit, :update]
 resources :orders, only: [:show, :destroy]

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
