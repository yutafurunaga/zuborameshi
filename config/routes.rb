Rails.application.routes.draw do

  namespace :public do
    get 'searches/search'
  end
  get 'searches/search'
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
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
   root to: 'homes#top'
  get "home/top"=> 'homes#top'
  resources :recipes do
  resources :comments
  end
  resources :customers
  end

 scope module: :public do
    root to: "homes#top"
    get "home/about"=> 'homes#about'
    get "search" => "searches#search"
    delete '/customers/:id/withdraw', to: 'customers#withdraw', as: 'customer_withdraw'

    resources :recipes do
    resources :comments
    resource :favorites
    get :favorite, to: "recipes#favorite"
    end

    resources :relationships
    resources :ingredients
    resources :steps
    resources :customers
    resources :tags

 	end
end
