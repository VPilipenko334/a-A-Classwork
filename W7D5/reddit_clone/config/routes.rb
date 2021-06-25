Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :index, :show ]
  resource :session, only: [:new, :create, :destroy]
    #think of sessions in terms of a cookie 
    # new --> resets cookie / create --> gives a user a cookie 
    #destroy --> logging a user out 

end
