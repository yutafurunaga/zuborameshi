Rails.application.routes.draw do

  namespace :public do
    get 'customers/index'
  end
  get 'customers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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

devise_scope :admin do
    get 'admin/sign_out' => 'admin/sessions#destroy'
  end

  namespace :admin do
   root to: 'homes#top'
  get "home/top"=> 'homes#top'
  end

 scope module: :public do
   root to: "homes#top"
    get "home/about"=> 'homes#about'
    resources :recipes
    resources :relationships
    resources :ingredients
    resources :steps
    resources :customers

 	end

end
