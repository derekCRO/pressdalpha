class CompanyRating < ApplicationRecord


	belongs_to :company, foreign_key: "company_id", required: false
	belongs_to :user, foreign_key: "user_id", required: false
	belongs_to :customer, foreign_key: "user_id", required: false
	belongs_to :job, foreign_key: "job_id", required: false

	private

end
