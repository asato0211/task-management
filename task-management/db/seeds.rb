# テストレコードを生成
3.times { Task.create!(title: 'Sample Task') }
2.times { Task.create!(title: 'Sample Task', done: true) }
