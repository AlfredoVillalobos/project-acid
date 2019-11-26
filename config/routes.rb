Rails.application.routes.draw do
  namespace :api do
    resources :tweets
    mount ActionCable.server => '/cable'
  end
end
