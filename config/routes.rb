Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "api/v1/registrations", sessions: "api/v1/sessions", confirmations: "api/v1/confirmations"}

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resource :session, only: [:create, :destroy] do
          put 'forgot_password', to: 'sessions#forgot_password'
          put 'reset_password', to: 'sessions#reset_password'
        end

        resource :registration, only: [:create, :update, :destroy]
        resources :institutions
        resources :courses, param: :slug do
          resources :topics
        end
        resources :assessments do
          resources :questions
        end
        resources :answers
        resources :ward_requests do
          member do
            get :toggle
          end
        end
      end
    end
  end
end
