# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180618144053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blog_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_category_id"
    t.string "author"
    t.text "tags"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name", null: false
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.float "price_per_hour", default: 0.0
    t.float "weekly_price_per_hour_3_months"
    t.float "weekly_price_per_hour_6_months"
    t.float "weekly_price_per_hour_12_months"
    t.float "fortnightly_price_per_hour_3_months"
    t.float "fortnightly_price_per_hour_6_months"
    t.float "fortnightly_price_per_hour_12_months"
    t.float "monthly_price_per_hour_3_months"
    t.float "monthly_price_per_hour_6_months"
    t.float "monthly_price_per_hour_12_months"
    t.string "mobile_cover_image_file_name"
    t.string "mobile_cover_image_content_type"
    t.integer "mobile_cover_image_file_size"
    t.datetime "mobile_cover_image_updated_at"
    t.string "mobile_icon_file_name"
    t.string "mobile_icon_content_type"
    t.integer "mobile_icon_file_size"
    t.datetime "mobile_icon_updated_at"
    t.index ["category_id"], name: "index_categories_on_category_id"
  end

  create_table "category_attribute_options", force: :cascade do |t|
    t.integer "category_attribute_id"
    t.string "options"
    t.integer "option_hours"
    t.integer "option_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_attributes", force: :cascade do |t|
    t.string "name"
    t.string "field_type"
    t.float "hour_per_item"
    t.float "material_cost"
    t.boolean "required"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_name"
    t.string "information"
    t.index ["category_id"], name: "index_category_attributes_on_category_id"
  end

  create_table "ckeditor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "companies", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "is_active"
    t.string "company_name"
    t.text "about_company"
    t.string "location"
    t.string "logo"
    t.string "service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "category_id"
    t.integer "user_id"
    t.float "latitude"
    t.float "longitude"
    t.string "zipcode"
    t.boolean "is_publish", default: false
    t.integer "servicearea_radius"
    t.string "servicestart_time"
    t.string "serviceend_time"
    t.string "service_type"
    t.bigint "postcode_id"
    t.bigint "partner_opening_times_id"
    t.boolean "instant_book", default: false
    t.boolean "preferred_partner", default: false
    t.integer "cancellation_amount"
    t.boolean "using_promo_material"
    t.boolean "staff_rotas_enable", default: false
    t.integer "selected_package"
    t.index ["partner_opening_times_id"], name: "index_companies_on_partner_opening_times_id"
    t.index ["postcode_id"], name: "index_companies_on_postcode_id"
  end

  create_table "companies_postcodes", id: false, force: :cascade do |t|
    t.bigint "postcode_id", null: false
    t.bigint "company_id", null: false
    t.index ["postcode_id", "company_id"], name: "index_companies_postcodes_on_postcode_id_and_company_id"
  end

  create_table "company_ratings", force: :cascade do |t|
    t.integer "job_id"
    t.decimal "score", precision: 8, scale: 2
    t.integer "user_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_selected_categories", force: :cascade do |t|
    t.integer "category"
    t.integer "company_id"
    t.string "name", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "category_id"
    t.integer "price_per_hour", default: 0
    t.string "service_type"
    t.float "weekly_price_per_hour_3_months", default: 0.0
    t.float "weekly_price_per_hour_6_months", default: 0.0
    t.float "weekly_price_per_hour_12_months", default: 0.0
    t.float "fortnightly_price_per_hour_3_months", default: 0.0
    t.float "fortnightly_price_per_hour_6_months", default: 0.0
    t.float "fortnightly_price_per_hour_12_months", default: 0.0
    t.float "monthly_price_per_hour_3_months", default: 0.0
    t.float "monthly_price_per_hour_6_months", default: 0.0
    t.float "monthly_price_per_hour_12_months", default: 0.0
  end

  create_table "company_selected_category_attributes", force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.string "field_type"
    t.float "hour_per_item"
    t.float "material_cost"
    t.boolean "required"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_selected_category_id"
    t.boolean "is_company_support", default: true
    t.integer "category_attribute_id"
    t.integer "company_selected_category_parent_id"
    t.string "price_per_hour"
    t.index ["category_id"], name: "index_company_selected_category_attributes_on_category_id"
  end

  create_table "companylocations", force: :cascade do |t|
    t.integer "company_id"
    t.string "zipcode"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companylocations_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "page_heading"
    t.text "page_description"
    t.string "slug"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active"
    t.index ["recipient_id", "sender_id"], name: "index_conversations_on_recipient_id_and_sender_id", unique: true
  end

  create_table "coupon_references", force: :cascade do |t|
    t.integer "coupon_id"
    t.string "code"
    t.integer "user_id"
    t.integer "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.string "coupon_type"
    t.integer "originator"
    t.date "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "enquirypostcodes", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "postcode"
    t.string "service_type"
    t.boolean "inform_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.integer "company_id"
    t.date "booking_date"
    t.string "booking_time"
    t.decimal "price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "view_job_id"
    t.datetime "post_date"
    t.integer "category_id"
    t.string "latitude"
    t.string "longitude"
    t.string "address"
    t.text "properties"
    t.string "zipcode"
    t.integer "staff_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country"
    t.text "propertytext"
    t.boolean "recurring"
    t.string "recurring_type"
    t.boolean "is_manual_booking", default: false
    t.bigint "manual_customers_id"
    t.integer "recurring_weeks"
    t.integer "subscription_id"
    t.boolean "rating_given"
    t.boolean "coupon_used"
    t.integer "coupon_id"
    t.boolean "coupon_refer"
    t.float "coupon_discount"
    t.index ["manual_customers_id"], name: "index_jobs_on_manual_customers_id"
  end

  create_table "manual_customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country"
    t.string "zipcode"
    t.float "latitude"
    t.float "longitude"
    t.bigint "company_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "partner_id"
    t.index ["company_id"], name: "index_manual_customers_on_company_id"
    t.index ["partner_id"], name: "index_manual_customers_on_partner_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "recipient_id"
    t.string "sent_by"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.boolean "stuck", default: false
  end

  create_table "packagedetails", force: :cascade do |t|
    t.string "package_name", null: false
    t.integer "order_limit", default: 100
    t.integer "postcode_limit", default: 100
    t.integer "user_limit", default: 2
    t.boolean "manual_bookings", default: false
    t.boolean "advanced_reports", default: false
    t.boolean "api_access", default: false
    t.integer "monthly_cost", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partner_opening_times", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start"
    t.date "end"
    t.time "starttime"
    t.time "endtime"
    t.boolean "is_open"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_partner_opening_times_on_company_id"
  end

  create_table "partnerpreferences", force: :cascade do |t|
    t.integer "company_id"
    t.integer "order_limit", default: 100
    t.integer "postcode_limit", default: 100
    t.integer "user_limit", default: 2
    t.boolean "manual_bookings", default: false
    t.boolean "advanced_reports", default: false
    t.boolean "api_access", default: false
    t.boolean "rota_enabled", default: true
    t.boolean "auto_allocate", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_partnerpreferences_on_company_id"
  end

  create_table "postcodes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_postcodes_on_company_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "facebook_link"
    t.string "site_email"
    t.string "phone_no"
    t.string "google_plus_link"
    t.integer "radius"
    t.string "twitter_link"
    t.string "instagram_link"
    t.string "linkedin_link"
    t.string "angellist_link"
    t.boolean "maintenance_mode"
    t.string "favicon"
    t.string "company_name"
    t.string "website_name"
    t.string "meta_description"
    t.boolean "registrations_available"
    t.boolean "bookings_available"
    t.string "site_language"
    t.string "time_zone"
    t.float "pressd_promise_fee", default: 0.0
  end

  create_table "staffs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_staffs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "recurring_type"
    t.integer "recurring_weeks_in_month"
    t.integer "recurring_months"
    t.integer "first_job_id"
    t.date "date_of_first_booking"
    t.decimal "recurring_price", precision: 8, scale: 2
    t.integer "user_id"
    t.integer "partner_id"
    t.integer "company_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.string "zipcode"
    t.boolean "is_active"
    t.date "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.text "properties"
    t.string "booking_time"
    t.integer "company_id"
    t.string "task_type"
    t.text "propertytext"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country"
    t.boolean "is_manual_booking", default: false
    t.bigint "manual_customers_id"
    t.index ["manual_customers_id"], name: "index_tasks_on_manual_customers_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.bigint "week_day_id"
    t.bigint "added_by_id"
    t.time "starting_time"
    t.time "ending_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_slotable_type"
    t.bigint "user_slotable_id"
    t.datetime "working_date"
    t.index ["added_by_id"], name: "index_time_slots_on_added_by_id"
    t.index ["user_slotable_type", "user_slotable_id"], name: "index_time_slots_on_user_slotable_type_and_user_slotable_id"
    t.index ["week_day_id"], name: "index_time_slots_on_week_day_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "partner_id"
    t.integer "company_id"
    t.integer "job_id"
    t.datetime "date"
    t.decimal "total_amount"
    t.decimal "company_amount"
    t.decimal "admin_amount"
    t.string "status"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "is_active"
    t.boolean "is_admin", default: false
    t.date "date"
    t.string "user_type"
    t.integer "company_id"
    t.text "about_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "phone"
    t.text "address"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.float "latitude"
    t.float "longitude"
    t.integer "companylocation_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country"
    t.string "zipcode"
    t.string "authentication_token"
    t.boolean "auto_assign_staff", default: false
    t.boolean "notifications_email", default: false
    t.boolean "notifications_push", default: false
    t.boolean "notifications_marketing", default: false
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.string "card_last4"
    t.integer "card_exp_month"
    t.integer "card_exp_year"
    t.string "card_type"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "been_referred"
    t.float "credit"
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.boolean "video_type"
    t.string "url"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "week_days", force: :cascade do |t|
    t.string "day_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_attributes", "categories"
  add_foreign_key "companies", "partner_opening_times", column: "partner_opening_times_id"
  add_foreign_key "companies", "postcodes"
  add_foreign_key "company_selected_category_attributes", "categories"
  add_foreign_key "companylocations", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "postcodes", "companies"
  add_foreign_key "time_slots", "week_days"
end
