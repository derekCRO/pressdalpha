json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :password_hash, :password_salt, :username, :is_admin, :is_active, :date
  json.url user_url(user, format: :json)
end
