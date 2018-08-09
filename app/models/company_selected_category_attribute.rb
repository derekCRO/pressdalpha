class CompanySelectedCategoryAttribute < ApplicationRecord


	belongs_to :company_selected_category,:inverse_of => :companycatatt

	private


end
