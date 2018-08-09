class Job < ApplicationRecord
	before_create :set_access_token
	include OrderBy

	serialize :properties, Hash
  serialize :propertytext, Hash
	belongs_to :company, foreign_key: "company_id", required: false
	belongs_to :category, foreign_key: "category_id", required: false
	belongs_to :user, foreign_key: "user_id", required: false
	belongs_to :customer, foreign_key: "user_id", required: false
	belongs_to :staff, foreign_key: "staff_id", required: false
	belongs_to :task
	scope :automatic_assign, -> { where(is_manual_booking: false) }
	scope :pending_jobs, -> (company_id) { automatic_assign.where(company_id: company_id, status: 'booking_made') }
	scope :assigned_jobs, -> (company_id) { automatic_assign.where(company_id: company_id, status: ['booking_confirmed', 'staff_enroute', 'booking_inprogress', 'dispute' ]) }
	scope :completed_jobs, -> (company_id) { automatic_assign.where(company_id: company_id, status: 'booking_complete') }

	scope :jobs_created_last_week, ->() {
  where('created_at >= ?', 1.week.ago).count}

	scope :jobs_last_week, ->() {
	where('booking_date >= ?', 1.week.ago)}

	scope :jobs_completed_last_week, ->() {
	where('booking_date >= ?', 1.week.ago).where(status: ['booking_complete'])}

	private
	def set_access_token
     self.view_job_id = generate_token
   end

   def generate_token
     loop do
       token = SecureRandom.hex(4)
       break token unless User.where(id: token).exists?
     end
   end
 end
