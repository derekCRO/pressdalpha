class CategoryAttribute < ApplicationRecord

  belongs_to :category,:inverse_of => :questions
  has_many(
    :category_attribute_options,
    :dependent => :destroy
  )
  #Nested attributes
  accepts_nested_attributes_for :category_attribute_options, reject_if: :all_blank, allow_destroy: true

  private


end
