ActionController::Routing::Routes.draw do |map|

  map.resources :vendor_test_plans, :has_one => :clinical_document, :member => {:inspect_content => :get,:validate => :get,:revalidate=>:get}

  map.resources :vendors

  map.resources :users

  map.resources :xds_patients

  map.resources(:patient_data, 
                :has_one  => [:registration_information, :support, :information_source, :advance_directive],
                :has_many => [:languages, :providers, :insurance_providers, 
                              :insurance_provider_patients, :insurance_provider_subscribers, 
                              :insurance_provider_guarantors, :medications, :allergies, :conditions, 
                              :comments, :results, :immunizations, 
                              :encounters, :procedures, :medical_equipments],
                :member   => {:set_no_known_allergies => :post, :checklist => :get, :edit_template_info => :get},
                :singular => :patient_data_instance) do |patient_data|
    patient_data.resources :vital_signs, :controller => 'results'
  end

  map.resources :document_locations

  map.resources :news

  map.root :controller => "vendor_test_plans"
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
