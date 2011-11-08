Nahan::Application.routes.draw do
  get "comments/index"

  match 'comments/:id/reply' => 'comments#reply', :as => :comments_reply
  
  match "comments/ding" => 'comments#ding', :as => :comments_ding


  get "users/avatar" => 'users#avatar', :as => :avatar

  # get "users/:username" => 'users#show_by_name', :as => :show_by_name

  get "profiles/edit"

  get "profiles/update"

  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions
  
  resources :users do
    resources :roles
    resource :profile
    resources :friends
    resources :comments
  end

  resources :categories
  resources :articles do
    resources :comments
  end


  resources :password_resets
  resources :pages
  
  resources :sent do
    member do
     put 'fdelete'
    end
  end

  resources :mailbox do
    collection do
      get 'trash'
      get 'newmail'
      get 'sent'
    end
  end

  resources :messages do
    member do
      get 'reply'
      get 'forward'
      put 'undelete'
      put 'fdelete'
    end
  end

  get 'mailbox' => 'mailbox#index', :as => :inbox


  root :to => "articles#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
