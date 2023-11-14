Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'Admin', at: 'api/v1/admin_auth', controllers: {
    registrations: "api/v1/admin_auth/registrations"
  }
  
  mount_devise_token_auth_for 'Employee', at: 'api/v1/employee_auth'

  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      namespace :admin do
        resources :absences, only: %i[show update]
        resources :admins, only: %i[index show] do
          collection do
            get :current_admin
          end
        end
        resources :employees, only: %i[index show]
        resources :notifications, only: %i[index update]
        resources :shifts, only: %i[index show update]
      end
      namespace :employee do
        resources :absences, only: %i[new create]
      end
    end
  end
end
