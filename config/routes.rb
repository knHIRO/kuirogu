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

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

get 'admin' => 'admin/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
