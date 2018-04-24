Rails.application.routes.draw do
  get '/users/:id/change_password', to:'users#change_password', as:'change_password'
  patch '/users/:id/change_password', to:'users#update_password', as:'update_password'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update]

  resources :posts, shallow: true do
    resources :comments, only: [:create, :destroy]
  end

  get '/', to:'welcome#index', as:'home'
  get '/about_us', to:'welcome#about_us', as:'about_us'


end
