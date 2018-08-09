class Postcode < ApplicationRecord

  has_and_belongs_to_many :company

  private

end
