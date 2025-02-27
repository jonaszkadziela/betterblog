Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments, except: %i(show index)
  end
  root "posts#index"
  get "/about", to: "pages#about"

  mount ActionCable.server => "/cable"
end
