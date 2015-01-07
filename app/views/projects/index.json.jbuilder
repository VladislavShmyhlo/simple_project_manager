json.array!(@projects) do |project|
  json.extract! project, :id, :updated_at, :name, :tasks
  # json.tasks do
  #   json.array! project.tasks
  # end
  # json.url project_url(project, format: :json)
end