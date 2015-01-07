json.extract! @task, :id, :updated_at, :description, :completed
json.comments do
  json.array! @task.comments {|comment|
    render comment
  }
end