Rails.application.routes.draw do
  get 'patients/show'

  root 'homes#index'

  get 'homes/index'

  get 'homes/users_index' => 'homes#users_index'

  get 'homes/receptionists_index' => 'homes#receptionists_index'

  get 'homes/create_doctor' => 'homes#create_doctor'

  get 'homes/doctors_index' => 'homes#doctors_index'

  get 'homes/:id/edit' => 'homes#edit'

  get 'homes/:id/show' => 'homes#show'

  get 'prescriptions/:id/edit' => 'prescriptions#edit'

  delete 'homes/:id' => 'homes#destroy' 

  patch 'homes/users_update/:id' => 'homes#update'

  patch 'prescriptions/prescriptions_update/:id' => 'prescriptions#update'

  delete 'prescriptions/:id' => 'prescriptions#destroy'

  get 'patients/:id/edit' => 'patients#edit'

  patch 'patients/patient_update/:id' => 'patients#update'
  
  devise_for :users
  #resources :home
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
