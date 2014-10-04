json.array!(@user_details) do |user_detail|
  json.extract! user_detail, :id, :user_id, :first_name, :last_name, :gender, :phone_number
  json.url user_detail_url(user_detail, format: :json)
end
