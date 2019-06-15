Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users/login", to: "sessions#new", as: "new_session"
  post "users/login", to: "sessions#create", as: "sessions"
end
