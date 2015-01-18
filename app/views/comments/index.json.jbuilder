json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :updated_at, :created_at
  json.url comment_url(comment, format: :json)
end
