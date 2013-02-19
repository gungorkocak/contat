Contat::Application.routes.draw do
  get "contacts/index"

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :contacts, only: [:index]

  root to: 'pages#landing'
  
end
