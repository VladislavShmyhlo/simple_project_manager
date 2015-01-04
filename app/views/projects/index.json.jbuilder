json.array!(@projects) do |project|
  json.extract! project, :id, :updated_at, :name
  json.tasks do
    json.array! project.tasks {|task|
      render task
    }
  end
  # json.url project_url(project, format: :json)
end