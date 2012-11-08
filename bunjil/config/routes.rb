Bunjil::Application.routes.draw do

  get "reports/create"

  root :to => "static#index"

  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'demo' => 'demo#start'

  match 'job_dash' => 'static#job_dash'
  match 'rss' => 'demo#rss'
  match 'intersection_check' => 'demo#intersection_check'
  match 'downloader' => 'demo#downloader'
  match 'processor' => 'demo#processor'
  match 'clear' => 'demo#clear'
  match 'clear_feed' => 'demo#clear_feed'

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions, only: [:new, :create, :destroy]
  #for security no need to show or edit sessions. 11/7 kg

  resources :areas
  resources :users
  resources :reports
  match 'email_report' => 'reports#email'
  match 'user/area_select' => 'users#area_select'
  match 'user/area_observation' => 'users#area_observation'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
