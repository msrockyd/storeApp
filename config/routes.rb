StoreApp::Application.routes.draw do
  resources :user_details do 
    collection do
      get 'edit'
      get 'update'
    end
  end


  get "track/index"
  get "track/show"
  get "admin_users/index"
  get "order_detail/index"
  get "order_detail/show"
  resources :orders do
    collection do
      get 'check_login'
      get 'update_order_status'
    end
  end

  resources :admin_users

  devise_for :users
  get "carts/index"
  get "carts/send_products_id"
  get "carts/update_base_cart_products_quantiy"
  get "carts/delete"
  get "home/login_last_url"
  resources :products do
    collection do
      get 'show_product'
      get 'update_category_select'
      get 'update_sub_category_select'
    end 
  end

  resources :sub_categories

  resources :categories

  resources :menu_categories

  get "dashboard/index", :controllers => { registrations: 'registrations' }
  root "home#index"
  get "home/index"
  get "home/show"
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
