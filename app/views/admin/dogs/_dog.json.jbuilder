json.extract! dog, :id, :photo, :first_name, :last_name, :breed, :color, :sex, :birthday, :user_id, :created_at, :updated_at
json.url dog_url(dog, format: :json)
json.photo url_for(dog.photo)
