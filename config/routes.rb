Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes with custom controllers
  devise_for :users,
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             },
             defaults: { format: :json }

  # API endpoints
  resources :messages, only: [:index, :create]
  
  # Twilio webhooks
  post 'twilio/status_callback', to: 'twilio_webhooks#status_callback', as: :twilio_status_callback
  
  # Action Cable
  mount ActionCable.server => '/cable'
end
