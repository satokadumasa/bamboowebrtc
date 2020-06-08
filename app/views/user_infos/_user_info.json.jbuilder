json.extract! user_info, :id, :user_id, :name, :mobile, :pref_id, :postal_code, :address, :created_at, :updated_at
json.url user_info_url(user_info, format: :json)
