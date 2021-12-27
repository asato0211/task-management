json.set! :task do
  json.extract! @task, :id, :title, :done, :created_at, :updated_at
end