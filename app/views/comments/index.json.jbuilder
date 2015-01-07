json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :reference
  json.url comment_url(comment, format: :json)
end
