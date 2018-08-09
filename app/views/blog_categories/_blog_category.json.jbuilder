json.extract! blog_category, :id, :name, :is_active, :created_at, :updated_at
json.url blog_category_url(blog_category, format: :json)
