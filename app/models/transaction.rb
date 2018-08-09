class Transaction < ApplicationRecord

	belongs_to :company, foreign_key: "company_id", required: false
	belongs_to :customer, foreign_key: "customer_id", required: false
	belongs_to :partner, foreign_key: "trainer_id", required: false
	belongs_to :job, foreign_key: "job_id", required: false

	scope :transaction_revenue_last_week, ->() {
  where('date >= ?', 1.week.ago).sum(:company_amount)}

	scope :transaction_revenue_admin_last_week, ->() {
  where('date >= ?', 1.week.ago).sum(:total_amount)}

	private
		def generate_random_id
			self.id = SecureRandom.uuid
		end

end
