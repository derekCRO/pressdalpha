json.extract! transaction, :id, :customer_id, :partner_id, :company_id, :job_id, :date, :total_amount, :company_amount, :admin_amount, :status, :transaction_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
