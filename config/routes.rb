Rails.application.routes.draw do
  
  devise_scope :user do
  	post 'sign_up.json', to: 'users/registrations#create'
  	post 'login.json', to: 'users/sessions#create'
  	delete 'logout.json', to: 'users/sessions#destroy'
  end

  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
