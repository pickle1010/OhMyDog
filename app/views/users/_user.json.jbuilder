json.extract! user, :id, :email, :dni, :first_name, :last_name, :address, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
