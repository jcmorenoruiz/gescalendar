Rails.application.routes.draw do
  
  
  resources :departments_request_types



  resources :default_request_types

  resources :request_types


  get 'requests/new'
  get 'requests/destroy'
  get "requests/stats"
  get "requests/calendar"
  resources :requests


  resources :default_line_calendars

  resources :default_calendars

  resources :line_calendars


  resources :enterprises, only: [:show,:new, :create,:edit,:update]
  resources :employees
  resources :departments
  resources :sessions, only: [:new, :create, :destroy]
  resources :calendars
  

  resources :calendars do
     resources :line_calendars, :only=> [:new, :create]
  end

  resources :availabilities, only: [:new, :create,:edit,:update,:destroy]

  get "employees/balance"
  match 'employees/balance/:id' => 'employees#balance', via: 'get'

  get "calendars/days"
  match 'calendars/days/:id' => 'calendars#days', via: 'get'

  get "departments/ausencias"
  match 'departments/ausencias/:id' => 'departments#ausencias', via: 'get'
  
  get "calendars/update_days"
  match 'calendars/update_days/:id' => 'calendars#update_days', via: 'patch'



  # Not logged in
  match '/signup', to: 'enterprises#new', via: 'get'

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'  
  match '/', to: 'static_pages#home', via: 'get'

  root 'static_pages#home'

  # redirect root if not action found
  #get '*path' => redirect('/') 
  



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
