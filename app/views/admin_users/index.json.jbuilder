json.array!(@admin_users) do |admin_user|
  json.extract! admin_user, :id, :user_id, :first_name, :last_name
  json.url admin_user_url(admin_user, format: :json)
end
