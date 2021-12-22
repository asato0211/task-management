require 'application_system_test_case'

class HomeIndexTest < ApplicationSystemTestCase
  setup do
    Task.create!(title: '未完了タスクのテストです')
    Task.create!(title: '完了済みタスクのテストです', done: true)
  end

  test 'Todoページと概要ページの表示' do
    visit root_path

    assert_selector '.brand-logo', text: 'タスク管理アプリ'
    assert_text '未完了タスクのテストです'

    # 「完了済みのタスクを表示」を押さないと完了済みタスク一覧は表示されない
    assert_no_text '完了済みタスクのテストです'
    click_on '概要'
    assert_text 'RailsとVueのサンプルアプリケーションです。'
  end
end
