json.extract! room, :id, :user_id, :title, :created_at, :updated_at
json.url room_url(room, format: :json)
