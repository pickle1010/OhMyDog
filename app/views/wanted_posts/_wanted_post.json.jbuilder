json.extract! wanted_post, :id, :body, :user_id, :created_at, :updated_at
json.url wanted_post_url(wanted_post, format: :json)
