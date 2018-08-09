class Task < ActiveRecord::Base

     serialize :properties, Hash
     serialize :propertytext, Hash
     belongs_to :company, foreign_key: "company_id", required: false
		 belongs_to :category, optional: true
		 has_one :job


		 private

end
