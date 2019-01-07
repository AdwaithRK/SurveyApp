Rails.application.routes.draw do
  get 'surveys/create'
  # devise_for :users
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  
  root to: redirect('/register/cmon_let_me_in')


  get '/features/edit_pro_pic'
  post '/features/save_new_pro_pic'

  get '/logged_in', to: 'users/logged_in#index'
  # get '/register', to: 'devise/registrations#new'
  
  # these routes can be rewritten as collection below
  resources :surveys, only: [:new, :create, :edit, :update]
  get '/surveys/stats', to: 'surveys#stats'
  get '/surveys/stats_survey', to: 'surveys#stats_survey'
  get '/surveys/thanks', to: 'surveys#thanks'
  get '/surveys/:link', to: 'surveys#attend'
  post '/surveys/submit', to: 'surveys#submit'
  post '/surveys/invite', to: 'surveys#invite'
  delete '/surveys/delete', to: 'surveys#delete'
  # put '/surveys/update', to: 'surveys#update'
  #rewritten

  # resources :surveys, only: [:new, :create, :update, :edit] do
  #   collection do
  #     get 'stats'
  #     get 'thanks'
  #     post 'submit'
  #     post 'invite'
  #   end
  # end
  
end
