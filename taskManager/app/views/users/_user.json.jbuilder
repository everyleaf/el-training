json.extract! user, :id, :mail, :user_name, :encrypted_password, :created_at, :updated_at
json.url user_url(user, format: :json)
