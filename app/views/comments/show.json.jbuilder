json.extract! @comment, :id, :body, :created_at, :updated_at
json.attachments do
  json.array! @comment.attachments, partial: 'attachments/attachment', as: :attachment
end
