json.extract! task, :id, :user_id, :category_id, :zipcode, :is_active, :booking_date, :created_at, :updated_at
json.url task_url(task, format: :json)
