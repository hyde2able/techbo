Rails.application.routes.draw do
  root to: 'entries#index'

  resources :entries do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'draft/:uid', to: 'entries#draft'
    end
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' } do
    delete '/logout', to: 'device/sessions#destroy', as: 'destroy_user_session'
  end

  #devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
  #                 controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations' }

  get '/tags', to: 'entries#tag_cloud', as: 'tag_cloud'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/me/edit', to: 'users#edit', as: 'edit_user'
  put '/me', to: 'users#update', as: 'update_user'
  get '/me', to: 'users#me', as: 'me'

  # API
  namespace :api do
    post 'md_view', to: 'libs#md_view', as: 'md_view'
    post 'diff', to: 'libs#diffy', as: 'diff'
  end
end
