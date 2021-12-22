# テストレコードを生成
3.times { Task.create!(title: '未完了タスク-テスト') }
2.times { Task.create!(title: '完了済みタスク-テスト', done: true) }
