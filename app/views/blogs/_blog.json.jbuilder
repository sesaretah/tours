json.extract! blog, :id, :title, :content, :agency_id, :uuid, :created_at, :updated_at
json.url blog_url(blog, format: :json)
