class CategoryAttributeOption < ApplicationRecord


  #
  ##Associations
  #
  belongs_to :category_attribute

  #
  ##Validations
  #
  validates(
    :options,
    presence: true
  )

  validates(
    :option_hours,
    presence: true,
    format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." },
    numericality: { greater_than: 0, less_than: 24 }
  )

  validates(
    :option_price,
    presence: true,
    format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." },
    numericality: { greater_than: 0, less_than: 10000 }
  )

  private


end
