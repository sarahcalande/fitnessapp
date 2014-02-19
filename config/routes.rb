FitnessApp::Application.routes.draw do
  resources :users do
    resources :goals, only: [:new, :create]
  end
  resources :foods, only: [:new, :show, :create, :index] do
    get "search", on: :collection
  end

  resources :goals, only: [:edit, :destroy, :show]
  resource :session, only: [:new, :create, :destroy]
  root to: 'users#home'
end
