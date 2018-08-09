class ManualCustomer < ApplicationRecord


  belongs_to :company, foreign_key: "company_id", required: false
  belongs_to :partner, foreign_key: "partner_id", required: false
  belongs_to :jobs
  has_many :jobs

  def formatted_name
  "#{first_name} #{last_name} | #{email} | #{zipcode}"
  end

  private


end
