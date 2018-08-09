class CompanySelectedCategory < ApplicationRecord


  belongs_to :company_selected_category, required: false
  has_many :companycatatt, :class_name => 'CompanySelectedCategoryAttribute', :inverse_of => :company_selected_category
  accepts_nested_attributes_for :companycatatt, allow_destroy: true
  belongs_to :category
  belongs_to :company, foreign_key: "company_id"

  private


end
