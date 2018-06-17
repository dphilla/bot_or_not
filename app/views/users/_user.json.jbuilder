json.extract! user, :id, :name, :phonenumber, :created_at, :updated_at
json.url user_url(user, format: :json)
