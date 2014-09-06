json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :manufacturer, :menu_category_id, :category_id, :sub_category_id, :description
  json.url product_url(product, format: :json)
end
