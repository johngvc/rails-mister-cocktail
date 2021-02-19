Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: "cocktails#index"
  # cocktails: Index, show, new, create
  resources :cocktails, only: %i[new create show] do
    # doses: new, create
    resources :doses, only: %i[new create]
  end

  # doses: delete
  resources :doses, only: [:destroy]
end
