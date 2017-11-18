Rails.application.routes.draw do
  devise_for :workers
  
  resources :workers do 
    member do 
      get :reset_password
      put :change_current_city
    end
  end
  resources :roles

  resources :categories do 
    resources :products
  end

  resources :stations do
  end

  resources :addresses do
    collection do
      get :suggestion
    end
  end

  resources :cities

  resources :couriers
end
