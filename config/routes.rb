Rails.application.routes.draw do
  root 'games#landing'

  resources :games do
    collection do
      post :new_game
      post :login
    end

    member do
      get :join
      get :continue
    end
  end
end
