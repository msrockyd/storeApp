json.array!(@menu_categories) do |menu_category|
  json.extract! menu_category, :id, :menu_text
  json.url menu_category_url(menu_category, format: :json)
end
