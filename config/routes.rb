Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/register/cmon_let_me_in')

  get '/logged_in', to: 'users/logged_in#index'
  post 'users/logged_in/new'
  # get '/register', to: 'devise/registrations#new'
  
end
