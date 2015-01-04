json.array!(@projects) do |project|
  json.extract! project, :id, :name, :updated_at
  json.tasks project.tasks, :id, :description, :completed
  # json.url project_url(project, format: :json)
end
