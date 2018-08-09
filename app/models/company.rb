class Company < ActiveRecord::Base
  # belongs_to :user,:inverse_of => :company

  belongs_to :partner, class_name: 'User', foreign_key: 'user_id', optional: true
  accepts_nested_attributes_for :partner # , update_only: true

  has_and_belongs_to_many :postcode

  has_many :time_slots, as: :user_slotable

has_many :packagedetails
has_many :company_ratings
has_many :jobs
has_many :messages
has_many :conversations, foreign_key: :recipient_id

  def average_rating
    company_ratings.sum(:score) / company_ratings.size
  end

  def cancellation_rate
    cancellation_amount.to_f / partner.company.jobs.count.to_f
  end

  # TODO: Update user to partner in view for nested form
  # accepts_nested_attributes_for :partner#, update_only: true

  has_many :company_selected_category, dependent: :destroy
  # has_many :time_slots
  has_many :partner_opening_times
  has_many :staffs, -> { where(user_type: 'Staff') }, class_name: 'User', foreign_key: 'company_id'

  has_attached_file :image, styles: {
    small: '150x150>',
    thumb: '50x50',
    search: '248x200',
    detail: '300x300',
    listing: '200x200>'
  }

  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  def image_url_thumb
    image.url(:small)
 end

  def as_json(_options = {})
    super(
      only: %i[
        id
        company_name
        location
        preferred_partner
        instant_book
      ], methods: %i[image_url_thumb average_rating]
    )
    end

  #
  # #Def to get orange and green companies
  #
  def self.get_companies_data(zipcode, properties, p_total_hours)
    company_ids = CompaniesPostcode.joins(:postcode).where('postcodes.name = ?', zipcode[0...4]).pluck(:company_id)

    companies = Company.all

    prop = eval(properties)
    prop.to_a
    text = {}

    sub_cat_id = []
    sub_cat_att_id = []
    answered_values = []
    total_hours = 0
    prop.each do |k, v|
      @cat = Category.find(k)
      v.to_a
      a = {}
      sub_cat_id << k
      v.each do |smk, smv|
        sub_cat_att_id << smk
        smk1 = smk.to_i
        smk = smk.to_i unless smk =~ /[^[:digit:]]+/
        if smk.is_a? Integer
          @attr = CategoryAttribute.find(smk)
          unless @attr.blank?
            if @attr.field_type == 'check_box'
              if smv == '1'
                total_hours += @attr.hour_per_item.to_i
                @opt = 'Yes'
                answered_values << true
              else
                @opt = 'No'
                answered_values << false
              end
              a[@attr.name] = @opt
            elsif @attr.field_type == 'text_field'
              total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif @attr.field_type == 'number_field'
              total_hours += @attr.hour_per_item.to_i
              a[@attr.name] = smv
            elsif @attr.field_type == 'radio'
              total_hours += @attr.hour_per_item.to_i
            end
          end

        else
          @attr = CategoryAttribute.find(smv)
          a[@attr.group_name] = @attr.name unless @attr.blank?
        end
        text[@cat.name] = a
      end
    end

    selected_attr = CompanySelectedCategoryAttribute.where(category_id: sub_cat_id)
    company_ids = selected_attr.pluck(:company_id).uniq
    companies = CompanySelectedCategoryAttribute.where(company_id: company_ids).group_by(&:company_id)
    green_companies = []
    orange_companies = []
    companies.each do |comp, values|
      if values.pluck(:is_company_support) == answered_values
        green_companies << comp
      elsif values.pluck(:is_company_support).include?(true)
        orange_companies << comp
      end
    end

    days = Company.where(id: companies.values.flatten.pluck(:company_id)).map { |company| company.time_slots.map { |ts| ts if (ts.ending_time.hour - ts.starting_time.hour) >= p_total_hours.to_i }.reject(&:nil?).group_by(&:user_slotable_id) }.reject(&:blank?)

    companies_with_green = Company.where(id: green_companies)

    companies_with_orange = Company.where(id: orange_companies)

    [companies_with_green, companies_with_orange]
  end

  private
end
