json.set! :tasks do
  json.array! @tasks do |task|
    json.extract! task, :id, :title, :done, :created_at, :updated_at
  end
end