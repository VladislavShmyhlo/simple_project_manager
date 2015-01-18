json.extract! @project, :id, :name, :updated_at, :created_at
json.tasks do
  json.array! @project.tasks, partial: 'tasks/task', as: :task
end