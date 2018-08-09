Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "users/sign_in" => "users#adduser", :as => :users_adduser
  root :to => 'users#index', :as => :users_index
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  #devise_for :users, controllers: {sessions: 'users/sessions'}


  def devise_path_names
      { sign_in: "sign_in", sign_up: "", registration: "register", sign_out: "logout" }
  end

  devise_for :users,  controllers: {sessions: 'users/sessions'}
  devise_for :partners, controllers: { sessions: "partners/sessions"}, path_names: devise_path_names #-> url.com/partners/login
  devise_for :customers, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  devise_for :staffs, controllers: { sessions: "staffs/sessions" }, path_names: devise_path_names #-> url.com/staffs/login

  get "customer/my_account" => "users#my_account", :as => :users_myaccount
  get "customer/transaction" => "users#transaction", :as => :users_transaction
  get "customer/messages" => "conversations#messagespage", :as => :conversations_messagespage
  get "customer/task_details/:id" => "users#task_details", :as => :users_task_details
  patch "customer/updateaccount/:id" => "users#updateaccount", :as => :users_updateaccount
  get "customer/job_detail" => "users#job_detail"


  get "task/step1" => "tasks#step1", :as => :tasks_step1
  get "task/step2/:id" => "tasks#step2", :as => :tasks_step2
  get "task/step3/:id/:cid" => "tasks#step3", :as => :tasks_step3
  patch "task/step3update/:id/:cid" => "tasks#step3update", :as => :tasks_step3update
  get "task/step4/:id/:cid" => "tasks#step4", :as => :tasks_step4
  patch "task/step4update/:id/:cid" => "tasks#step4update", :as => :tasks_step4update
  get "task/step5/:id/:cid" => "tasks#step5", :as => :tasks_step5
  patch "task/step5update/:id/:cid" => "tasks#step5update", :as => :tasks_step5update
  get "task/step6/:id/:cid" => "tasks#step6", :as => :tasks_step6
  patch "task/step6update/:id/:cid" => "tasks#step6update", :as => :tasks_step6update
  get "job/save/:id/:cid" => "jobs#save", :as => :jobs_save
  get "customer/list" => "users#list", :as => :users_list
  get "videos/allvideo" => "videos#allvideo", :as => :videos_allvideo
  get '/about' => 'pages#about'
  get '/becomeapartner' => 'pages#becomeapartner'
  get '/careers' => 'pages#careers'
  get '/cleaning' => 'pages#cleaning'
  get '/legalinformation' => 'pages#legalinformation'
  get '/get_time_slots' => 'tasks#get_time_slots'

  resources :charges
  resources :users
  resources :partners, controller: 'users', type: 'Partner'
  resources :customers, controller: 'users', type: 'Customer'
  resources :staffs, controller: 'users', type: 'Staff'
  resources :tasks
  resources :notifications
  resources :blogs
  resources :videos
  resources :jobs
  resources :companies
  resources :transactions
  resources :conversations, only: [:create] do
      resources :messages, only: [:create]
  member do
    post :close
  end
end

  namespace :admin do
    get '', to:'users#dashboard', as: '/'
    get "users/dashboard" => "users#dashboard", :as => :users_dashboard
    get "users/partner" => "users#partner"
    get "users/staff" => "users#staff"
    get "users/customer" => "users#customer"
    get "users/viewcustomer/:id" => "users#viewcustomer", :as => :view_customer
    get "categories/sub/:id" => "categories#sub", :as => :sub_category
    get "categories/subnew/:id" => "categories#subnew", :as => :newsub_category
    get "categories/subedit/:id/:cid" => "categories#subedit", :as => :subedit_category
    patch "categories/subupdate/:id/:cid" => "categories#subupdate", :as => :subupdate_category
    post "categories/subcreate/:id" => "categories#subcreate", :as => :subcreate_category
    patch "jobs/jobs_update/:id" => "jobs#jobs_update", :as => :jobs_update
    get "jobs/list_manual" => "jobs#list_manual", :as => :jobs_list_manual
    get "jobs/list" => "jobs#list", :as => :jobs_list
    get "jobs/add_staff/:id" => "jobs#add_staff", :as => :jobs_add_staff
    get "jobs/details/:id" => "jobs#details", :as => :jobs_details
    get "jobs/new" => "jobs#new", :as => :jobs_new
    get "jobs/newmanual" => "jobs#newmanual", :as => :jobs_new_manual
    post "jobs/new" => "jobs#create", :as => :add_jobs_new
    get "transactions/list" => "transactions#list", :as => :transactions_list
    post "packagedetails/new" => "packagedetails#create", :as => :admin_new_packagedetails
    get '/reports/overall_revenue' => 'reports#overall_revenue'
    get '/reports/overall_bookings' => 'reports#overall_bookings'
    get '/reports/capacity_usage' => 'reports#capacity_usage'
    get '/reports/customer_retention' => 'reports#customer_retention'
    get '/reports/money_due_payrun' => 'reports#money_due_payrun'
    get '/reports/recurring_vs_new_customers' => 'reports#recurring_vs_new_customers'
    get '/reports/overall_revenue_json' => 'reports#overall_revenue_json'
    get '/reports/overall_bookings_json' => 'reports#overall_bookings_json'
    get '/reports/overall_bookings_last_week_json' => 'reports#overall_bookings_last_week_json'
    get '/reports/transaction_revenue_last_week_json' => 'reports#transaction_revenue_last_week_json'
    get '/reports/recurring_vs_new_customers_bookings_json' => 'reports#recurring_vs_new_customers_bookings_json'
    get '/reports/recurring_vs_new_customers_bookings_last_week_json' => 'reports#recurring_vs_new_customers_bookings_last_week_json'
    get '/reports/customer_retention_json' => 'reports#customer_retention_json'
    get '/conversations/messagespage/:id' => 'conversations#messagespage', :as => :conversation_messagespage
    get '/oops_internal' => 'pages#oops_internal'
    get '/company_ratings' => 'companies#company_ratings'

    resources :jobs
    resources :subscriptions
    resources :users
    resources :categories
    resources :site_settings
    resources :contents
    resources :companies do
      member do
        put 'promo_materials_on'
        put 'promo_materials_off'
        put 'preferred_partner_on'
        put 'preferred_partner_off'
      end
    end
    resources :packagedetails
    resources :blogs
    resources :videos
    resources :transactions
    resources :blog_categories
    resources :postcodes
    resources :enquirypostcodes
    resources :conversations
    resources :notifications
end

  namespace :partner do
    root :to => "users#dashboard", as: 'partner/dashboard'
    get "users/dashboard" => "users#dashboard", :as => :users_dashboard
    get "users/profile" => "users#profile"
    get "users/customer_list" => "users#customer_list"
    get "companies/company_profile" => "companies#company_profile"
    get "company_selected_categories/selected_category" => "company_selected_categories#selected_category"
    get "company_selected_categories/manage_option/:id" => "company_selected_categories#manage_option", :as => :company_selected_categories_manage_option
    patch "users/profile_update/:id" => "users#profileupdate", :as => :users_profileupdate
    patch "companies/company_profile_update/:id" => "companies#companyprofileupdate", :as => :companies_companyprofileupdate
    patch "jobs/jobs_update/:id" => "jobs#jobs_update", :as => :jobs_update
    get "jobs/list_manual" => "jobs#list_manual", :as => :jobs_list_manual
    get "jobs/list" => "jobs#list", :as => :jobs_list
    get "jobs/add_staff/:id" => "jobs#add_staff", :as => :jobs_add_staff
    get "jobs/details/:id" => "jobs#details", :as => :jobs_details
    get "jobs/manualdetails/:id" => "jobs#manualdetails", :as => :jobs_manualdetails

    get "transactions/list" => "transactions#list", :as => :transactions_list
    get "company_selected_categories/sub/:id" => "company_selected_categories#sub", :as => :sub_category
    get "company_selected_categories/subnew/:id" => "company_selected_categories#subnew", :as => :newsub_category
    get "company_selected_categories/subedit/:id/:cid" => "company_selected_categories#subedit", :as => :subedit_category
    patch "company_selected_categories/subupdate/:id/:cid" => "company_selected_categories#subupdate", :as => :subupdate_category
    post "company_selected_categories/subcreate/:id" => "company_selected_categories#subcreate", :as => :subcreate_category
    patch "company_selected_categories/update_category_attribute/:id" => "company_selected_categories#update_category_attribute", :as => :update_category_attribute
    get '/reports/overall_revenue' => 'reports#overall_revenue'
    get '/reports/overall_bookings' => 'reports#overall_bookings'
    get '/reports/capacity_usage' => 'reports#capacity_usage'
    get '/reports/customer_retention' => 'reports#customer_retention'
    get '/reports/money_due_payrun' => 'reports#money_due_payrun'
    get '/reports/recurring_vs_new_customers' => 'reports#recurring_vs_new_customers'
    get '/reports/overall_revenue_json' => 'reports#overall_revenue_json'
    get '/reports/overall_bookings_json' => 'reports#overall_bookings_json'
    get '/reports/overall_bookings_last_week_json' => 'reports#overall_bookings_last_week_json'
    get '/reports/transaction_revenue_last_week_json' => 'reports#transaction_revenue_last_week_json'
    get '/reports/recurring_vs_new_customers_bookings_json' => 'reports#recurring_vs_new_customers_bookings_json'
    get '/reports/recurring_vs_new_customers_bookings_last_week_json' => 'reports#recurring_vs_new_customers_bookings_last_week_json'
    get '/reports/customer_retention_json' => 'reports#customer_retention_json'
    get "messages" => "conversations#messagespage", :as => :conversations_messagespage
    get "manual_customers/details/:id" => "manual_customers#details", :as => :manual_customers_details

    get   "companies/add-hours"  => "companies/add_hours",  as: :add_company_hours
    post  "companies/save-hours" => "companies/save_hours", as: :save_company_hours
    patch "companies/save-hours" => "companies/save_hours", as: :update_company_hours
    delete "companies/destroy_hours/:id" => "companies#destroy_hours", as: :destroy_hours
    get   "companies/rota-list" => "companies/rota_list",   as: :rota_list
    post  "companies/save_staff_counts", to: "companies#save_staff_counts", as: :save_staff_counts


    get '/oops_internal' => 'pages#oops_internal'


    resources :jobs do
      member do
        put 'staff_enroute'
        put 'booking_inprogress'
        put 'booking_complete'
        put 'booking_rejected'
      end
    end
    resources :notifications
    resources :subscriptions
    resources :users
    resources :packagedetails do
      member do
        put 'update_partner_package'
      end
    end
    resources :manual_customers
    resources :categories
    resources :site_settings
    resources :contents
    resources :companies
    resources :company_selected_categories
    resources :transactions
    resources :postcodes
    resources :partner_opening_times
    resources :conversations, only: [:create] do
        resources :messages, only: [:create]
    end
  end

  namespace :staff do
    root :to => "users#dashboard", as: 'staff/dashboard'
    get "users/dashboard" => "users#dashboard", :as => :users_dashboard
    get "users/profile" => "users#profile"
    patch "users/profile_update/:id" => "users#profileupdate", :as => :users_profileupdate
    get   "companies/add-hours"  => "companies/add_hours",  as: :add_company_hours
    post  "companies/save-hours" => "companies/save_hours", as: :save_company_hours
    patch "companies/save-hours" => "companies/save_hours", as: :update_company_hours
    get   "companies/replicate-hours" => "companies#duplicate_working_hours"#, as: :update_company_hours
    post  "re_assign_slot" => "companies#re_assign_slot",   as: :re_assign_slot
    get '/reports/bookings_complete_last_week_json' => 'reports#bookings_complete_last_week_json'
    get "jobs/list" => "jobs#list", :as => :jobs_list
    get "jobs/add_staff/:id" => "jobs#add_staff", :as => :jobs_add_staff
    get "jobs/details/:id" => "jobs#details", :as => :jobs_details
    get "jobs/new" => "jobs#new", :as => :jobs_new
    post "jobs/new" => "jobs#create", :as => :add_jobs_new

    resources :jobs
    resources :notifications
    resources :users
    resources :manual_customers
    resources :postcodes
    resources :partner_opening_times
  end


devise_scope :user do
  namespace :api do
    namespace :v1 do
      resources :problems
      resources :sessions
      resources :zendesk_session
        post "/auth", :to => 'authentication#create'
        post "/sign_in", :to => 'sessions#create'
        post "/sign_up", :to => 'registrations#create'
        delete "/sign_out", :to => 'sessions#destroy'
        get "/get_user_info", :to => 'user_info#finddetails'
        patch "/get_user_info", :to => 'user_info#updateaccount'
        get "/get_conversations", :to => 'conversations#findconversations'
        get "/get_messages", :to => 'messages#findmessages'
        post "/send_message", :to => 'send_message#sendmessage'
        get "/get_jobs", :to => 'jobs#findjobs'
        get "/get_completed_jobs", :to => 'completed_jobs#findjobs'
        get "/get_recurring_jobs", :to => 'recurring_jobs#findjobs'
        get "/get_selected_job", :to => 'selected_job#findjob'
        post "/new_conversation", :to => 'new_conversation#create'
        get "/does_convo_exist", :to => 'does_convo_exist#convoexist'
        patch "/update_conversation_to_true", :to => 'update_conversation_to_true#updateconversation'
        get "/notifications_count", :to => 'notifications#notificationcount'
        get "/notifications_unread_list", :to => 'notifications#notificationsunreadlist'
        patch "/notifications_update_single", :to => 'notifications#updatesinglenotification'
        patch "/notifications_update_all", :to => 'notifications#updateallundreadnotifications'
        get "/get_user_notifications_settings", :to => 'user_notifications_settings#findnotificationsettings'
        patch "/update_user_notifications_settings", :to => 'user_notifications_settings#updatenotificationsettings'
        get "/get_all_subscriptions", :to => 'subscriptions#findallsubscriptions'
        get "/get_single_subscription", :to => 'subscriptions#findsinglesubscription'
        patch "/leave_feedback", :to => 'leave_feedback#newcompanyrating'
        patch "/create_job", :to => 'create_job#createjob'
        patch "/change_password", :to => 'sessions#update_password'
        get "/get_payment_info", :to => 'add_payment_info#retrieve_details'
        patch "/add_payment_info", :to => 'add_payment_info#add_details'
        patch "/cancel_job", :to => 'cancel_job#canceljob'
        post  "/forget_password", :to => 'sessions#forget_password'
        get "/get_referral_code", :to => 'refer_a_friend#findcoupon'
        post "/create_referral_code", :to => 'refer_a_friend#create'
        post "/coupon_check", :to => 'coupon#couponing'
        post "/get_prices", :to => 'pricing#get_prices'
        get "/do_card_details_exist", :to => 'charges#card_exist'
        patch "/create_stripe_customer", :to => 'charges#create'

      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :category_attributes
      resources :postcode_services_find
      resources :companies, only: [] do
        get :get_companies, on: :collection
      end
      resources :calendars, only: [] do
        collection do
          get :get_days
          get :get_time_slots
        end
      end
      resources :calendars_rebook, only: [] do
        collection do
          get :get_days
          get :get_time_slots
        end
      end
      post "/enquirypostcodes", :to => 'enquirypostcodes#create'
      get "/get_company_list", :to => 'company_list#getcompanies'
    end
  end

  require 'sidekiq/web'
  # ...
  mount Sidekiq::Web, at: '/sidekiq'
end
