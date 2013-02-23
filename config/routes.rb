Contat::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations',
                                         sessions: 'sessions'       }

  resources :contacts, only: [:index]
  
  scope "api", defaults: { format: "json" }, as: :api do
    resources :contacts, except: [:new, :edit]
  end

  root to: 'pages#landing'
  
end
