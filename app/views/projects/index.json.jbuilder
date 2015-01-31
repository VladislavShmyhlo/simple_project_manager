json.array!(@projects) do |project|
    json.partial! project
    json.tasks do
      json.array! project.tasks, partial: 'tasks/task', as: :task
    end
end