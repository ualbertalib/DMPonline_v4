DMPonline4::Application.routes.draw do
  
  devise_for :users, :controllers => {:registrations => "registrations", :confirmations => 'confirmations'}
  resources :contacts, :controllers => {:contacts => 'contacts'}
    
    # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  ActiveAdmin.routes(self)

  get "about_us" => 'static_pages#about_us', :as => "about_us"
 
  resources :dmptemplates
  resources :phases
  resources :versions
  resources :sections
  resources :questions
  resources :question_themes
  
  resources :themes
  resources :guidances
  
  resources :answers
  resources :plan_sections
  
  resources :projects do
  	resources :plans do
		member do
			get 'status'
			get 'locked'
			get 'answer'
			post 'delete_recent_locks'
			post 'lock_section'
			post 'unlock_section'
			post 'unlock_all_sections'
			get 'export'
			get 'warning'
		end
	end
	member do
		get 'share'
		post 'invite'
	end
  end
  resources :project_partners
  resources :project_groups

  resources :users
  resources :user_statuses
  resources :user_types
  
  resources :user_role_types
  resources :user_org_roles
  
  resources :organisations do
  	member do
		get 'children'
		get 'templates'
	end
end
  resources :organisation_types
  resources :pages
 
  resources :file_types
  resources :file_uploads
   
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
  # match ':controller(/:action(/:id))(.:format)'
end
