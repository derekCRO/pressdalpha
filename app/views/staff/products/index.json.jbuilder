json.array!(@products) do |product|
  json.extract! product, :id, :title, :description, :serial, :weight, :pt_weight, :pd_weight, :rh_weight, :stainless, :moisture, :category_id, :category, :make, :model, :image_url
  json.url product_url(product, format: :json)
end
