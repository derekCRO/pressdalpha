json.extract! job, :id, :user_id, :task_id, :company_id, :booking_date, :booking_time, :price, :status, :created_at, :updated_at
json.url job_url(job, format: :json)
