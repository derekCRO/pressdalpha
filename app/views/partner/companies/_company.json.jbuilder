json.extract! company, :id, :first_name, :last_name, :email, :is_active, :company_name, :about_company, :location, :logo, :service, :created_at, :updated_at
json.url company_url(company, format: :json)
