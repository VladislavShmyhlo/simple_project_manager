json.partial! @task
json.comments do
  json.array! @task.comments do |comment|
    json.extract! comment, :id, :updated_at, :body, :created_at
    json.attachments do
      json.array! comment.attachments, partial: 'attachments/attachment', as: :attachment
    end
  end
end