Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :phone_app do 
    get '/', to: "app#show", as: :root
    get 'sign_out', to: "app#sign_out", as: :sign_out

    get 'another_page', to: "app#another_page"

    post 'send_notification', to: "push_notifications#send_sample_notification", as: :send_notification
  end
  


  root to: redirect('phone_app')
end
