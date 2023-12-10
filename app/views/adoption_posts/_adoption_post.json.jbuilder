json.extract! adoption_post, :id, :body, :user_id, :created_at, :updated_at
json.url adoption_post_url(adoption_post, format: :json)
