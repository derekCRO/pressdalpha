class Blog < ApplicationRecord



	belongs_to :blog_category

	has_attached_file :image, styles: {
	         small: '150x150>',
	         thumb: '50x50',
	         search: '248x200',
	         detail: '750x283',
	         listing: '298x198>'
	      }

   validates_attachment :image, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png" ] }

	 private

end
