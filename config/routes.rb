Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'phone/landing', to: "push_notifications#show", as: :phone_app_landing
  get 'phone/another_page', to: "push_notifications#another_page", as: :phone_app_another_page
  post 'phone/send_notification', to: "push_notifications#send_sample_notification", as: :phone_app_send_notification

  root to: redirect('phone/landing')
end
