json.extract! content, :id, :page_heading, :page_description, :slug, :is_active, :created_at, :updated_at
json.url content_url(content, format: :json)
