Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "api/v1/registrations", sessions: "api/v1/sessions", confirmations: "api/v1/confirmations"}

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :users, only: [:index, :show]
        resource :session, only: [:create, :show, :destroy] do
          put 'forgot_password', to: 'sessions#forgot_password'
          put 'reset_password', to: 'sessions#reset_password'
        end

        resource :registration, only: [:create, :update, :destroy] do
          get :family
        end
        resources :institutions
        resources :courses, param: :slug do
          collection do
            post :import_data
          end
          resources :topics do
            collection do
              post :import_data
            end
          end
        end

        resources :questions do
          collection do
            post :import_data
          end
          member do
            post :set_score
          end
          resources :answer_options
        end

        resources :assessments do
          resources :answers
          resources :assessment_questions
          resources :assessment_results, only: [:index, :show, :destroy]

          member do
            post :answer
            get :complete_assessment
          end
        end

        resources :answers do
          collection do
            get :marking
          end
          member do
            post :score
          end
        end

        resources :assessment_results, only: [:index, :show, :destroy]

        resources :study_groups
        resources :attendances
        resources :group_memberships, only: [:create, :destroy]
        resources :attendance_users, only: [:create, :destroy]

        resources :ward_requests do
          member do
            get :approve
          end
        end

        resources :grading_charts
      end
    end
  end
end
