module OrderBy
  extend ActiveSupport::Concern

  included do
      scope :default_order,    -> { order 'id' }
      scope :reverse_order,    -> { order 'id desc' }
    end
end
