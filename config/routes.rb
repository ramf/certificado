Rails.application.routes.draw do
  resources :students do
  member do
    # /agreements/:id/export
    get 'export'
  end
end
  get 'activities/activities'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'associate/index'
  post 'associate/associate'

  devise_for :users
  resources :users
  resources :texts
  resources :spendings
  resources :spendings
# /spendings_export
  root "agreements#index"
  get '/spending_export' => 'spendings#export'

 resources :agreements do
  member do
    # /agreements/:id/export
    get 'export'
    get 'send_email'
  end
end
end
