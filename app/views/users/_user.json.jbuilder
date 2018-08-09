json.extract! user, :id, :first_name, :last_name, :email, :is_active, :is_admin, :date, :user_type, :company_id, :about_me, :created_at, :updated_at
json.url user_url(user, format: :json)
