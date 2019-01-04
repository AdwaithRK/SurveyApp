Rails.application.routes.draw do
  get 'surveys/create'
  # devise_for :users
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  
  root to: redirect('/register/cmon_let_me_in')

  get '/logged_in', to: 'users/logged_in#index'
  # get '/register', to: 'devise/registrations#new'
  
  # these routes can be rewritten as collection below
  resources :surveys, only: [:new, :create]
  get '/surveys/stats', to: 'surveys#stats'
  get '/surveys/thanks', to: 'surveys#thanks'
  get '/surveys/:link', to: 'surveys#attend'
  post '/surveys/submit', to: 'surveys#submit'
  post '/surveys/invite', to: 'surveys#invite'
  delete '/surveys/delete', to: 'surveys#delete'
  #rewritten

  # resources :surveys, only: [:new, :create] do
  #   collection do
  #     get 'stats'
  #     get 'thanks'
  #     post 'submit'
  #     post 'invite'
  #   end
  # end
  
end
