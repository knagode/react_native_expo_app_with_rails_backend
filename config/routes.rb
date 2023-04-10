Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :phone_app do 
    get '/', to: "app#show", as: :root
    get 'sign_out', to: "app#sign_out", as: :sign_out
  end

  
  get 'phone/another_page', to: "push_notifications#another_page", as: :phone_app_another_page
  post 'phone/send_notification', to: "push_notifications#send_sample_notification", as: :phone_app_send_notification
  post 'phone/login', to: "push_notifications#fake_login", as: :phone_app_login
  post 'phone/logout', to: "push_notifications#fake_logout", as: :phone_app_logout

  root to: redirect('phone_app')
end
