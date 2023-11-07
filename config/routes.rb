Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      namespace :admin do
        resources :absences, only: %i[show update]
        resources :admins do
          collection do
            get :current_admin
          end
        end
      end

      mount_devise_token_auth_for 'Admin', at: 'admin_auth', controllers: {
        registrations: "api/v1/admin_auth/registrations"
      }

      mount_devise_token_auth_for 'Employee', at: 'employee_auth'
      as :employee do
        # Define routes for Employee within this block.
      end
    end
  end
end
