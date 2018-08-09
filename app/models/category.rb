class Category < ActiveRecord::Base
    #attr_accessor :name, :price_per_hour, :category_id, :image, :image_url, :is_active, :questions_attributes

    belongs_to :category, required: false
    has_one :company_selected_category
    has_many :children, :dependent => :destroy, :class_name => 'Category'
    has_many :questions, :class_name => 'CategoryAttribute', :inverse_of => :category
    has_many :category_attribute_options, through: :questions, dependent: :destroy
    has_many :tasks
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_attached_file :image, styles: {
            small: '150x150>',
            thumb: '50x50',
            search: '248x200',
            detail: '300x300',
            listing: '200x200>'
          }

    has_attached_file :mobile_cover_image, styles: {
            small: '150x150>',
            thumb: '50x50',
            search: '248x200',
            detail: '300x300',
            listing: '200x200>'
          }

    has_attached_file :mobile_icon, styles: {
            small: '150x150>',
            thumb: '50x50',
            search: '248x200',
            detail: '300x300',
            listing: '200x200>'
          }

   validates_attachment :image, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png" ] }
   validates_attachment :mobile_cover_image, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png" ] }
   validates_attachment :mobile_icon, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png" ] }

  def image_url
  image.url(:small)
  end

  def mobile_cover_image_url
  mobile_cover_image.url(:small)
  end

  def mobile_icon_url
  mobile_icon.url(:small)
  end

   private

end
