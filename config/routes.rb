Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about',as:"about"
  devise_for :users
  
  resources:users, only:[:index,:edit,:show,:update] do
    resource :relationships, only: [:create, :destroy] do
      member do
        get :follows, :followers
      end
    end
  end
  
  
  resources:books, only:[:index,:edit,:show,:create,:destroy,:update] do
    resource:favorites, only: [:create,:destroy]
    resources:book_comments, only: [:create,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
