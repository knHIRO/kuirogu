json.extract! post, :id, :address, :latitude, :longitude, :created_at, :updated_at
json.url post_url(post, format: :json)
