Socialbeam::Application.routes.draw do
  resources :scribbles do
    resources :scribble_comments
  end
  resources :users do |user|
    resources :messages do
      collection do
        post 'delete_multiple'
      end
    end
  end
  resource :socialbeams do
    collection do
      get 'home'
      get 'loadmorescribbles'
    end
  end
  resources :user_sessions
  resources :newsfeeds
  root :to => 'socialbeams#home'
  get  "refresh"  => "socialbeams#refreshscribbles", :as => "refresh"
  get "votedup"  => "socialbeams#votedup", :as => "votedup"
  get  "voteddown"  => "socialbeams#voteddown", :as => "voteddown"

  #Sessions & Users
  get "logout_user" => "user_sessions#destroy", :as => "logout_user"
  get "login_user" => "user_sessions#new", :as => "login_user"
  get "signup" => "users#new", :as => "signup"
  match "/myconnections/:beamer_id" => "users#showconnections", :as=>"myconnections"
  match "users/:beamer_id" => "users#show" , :as => 'profile'

  resources :friendships do
    collection do
      get 'req',:as=>"addfriend"
      get 'accept',:as=>"accept_fr"
      get 'reject',:as=>"reject_fr"
    end
  end
  #match "friendships/:beamer_id" => "friendships#req", :as=>"addfriend"
  #match "friendships/:beamer_id" => "friendships#accept", :as=>"accept_fr"
  #match "friendships/:beamer_id" => "friendships#reject", :as=>"reject_fr"

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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
end
