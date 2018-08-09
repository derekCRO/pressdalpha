class User < ActiveRecord::Base
	include OrderBy

	has_many :messages
	has_many :jobs
	has_many :subscriptions
	has_many :conversations, foreign_key: :sender_id
	has_many :notifications, foreign_key: :recipient_id
	has_many :company_ratings

	has_one :partner
	has_one :customer
	has_one :staff


	def overall_rating
		company_ratings.sum(:score) / company_ratings.size
	end

	self.inheritance_column = :user_type
	# will subclass the User model

	scope :partners, -> { where(user_type: 'Partner') }
	scope :customers, -> { where(user_type: 'Customer') }
	scope :staffs, -> { where(user_type: 'Staff') }

	has_one :companylocation, :inverse_of => :user
  accepts_nested_attributes_for :companylocation

	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_attached_file :image, styles: {
    small: '150x150>',
    thumb: '50x50',
		search: '248x200',
		detail: '300x300',
    listing: '200x200>'
  }

  validates_attachment :image, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png" ] }

  class << self
    def user_types
       %w(Staff Customer Partner)
    end
  end

	def image_url_thumb
	 image.url(:small)
 end

  def fullname
    [first_name, last_name].join(" ")
  end

	def available_slots
    data_arr = self.company.time_slots.pluck(:week_day_id, :starting_time, :ending_time)
    business_hours = []
    restricted_hours = []
    data_arr.each do |arr_ele|
      available_hours_hash = {dow: [arr_ele[0]-1], start: arr_ele[1].strftime("%H:%M"), end: arr_ele[2].strftime("%H:%M")}
      business_hours << available_hours_hash
      restricted_hours_hash = {start: arr_ele[1].strftime("%H:%M"), end: arr_ele[2].strftime("%H:%M")}
      restricted_hours << restricted_hours_hash
    end
    return business_hours, restricted_hours
  end

	def reset_password!(password)
		self.id = id
    self.reset_password_token = nil
    self.password = password
    save
  end


	private


end
