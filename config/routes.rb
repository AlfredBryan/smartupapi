Rails.application.routes.draw do

  devise_for :users
  # devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions", confirmations: "confirmations"}

  namespace :api do
    namespace :v1 do
      resource :session, only: [:create, :destroy] do
        put 'forgot_password', to: 'sessions#forgot_password'
        put 'reset_password', to: 'sessions#reset_password'
      end

      resource :registration, only: [:create, :destroy]
    end
  end
end
