json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :updated_at, :created_at
  json.attachments do
      json.array! comment.attachments, partial: 'attachments/attachment', as: :attachment
    end
end
