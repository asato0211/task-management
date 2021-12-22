require 'application_system_test_case'

class TodoTest < ApplicationSystemTestCase
  setup do
    @task_not_finished = Task.create!(title: 'Railsの学習')
    @task_finished     = Task.create!(title: 'Vueの学習', done: true)

    visit root_path
  end

  # 完了済みのタスクはデフォルトで非表示
  #「完了済みのタスクを表示」ボタンをクリックすると表示される
  test 'タスク管理画面を表示し、「完了済みのタスクを表示」をクリック' do
    assert_text 'Railsの学習'
    assert_no_text 'Vueの学習'

    click_on '完了済みのタスクを表示'
    assert_text 'Railsの学習'
    assert_text 'Vueの学習'
  end

  test '新規タスクを追加' do
    fill_in 'new-task-form', with: 'Capyabaraの学習'
    click_on 'add'
    assert_text 'Capyabaraの学習'
  end

  test '完了済みタスク一覧へ移動' do
    assert_text 'Railsの学習'
    click_on 'check_box_outline_blank', match: :first
    assert_no_text 'Railsの学習'

    click_on '完了済みのタスクを表示'
    assert_text 'Railsの学習'
  end

  test '未完了タスク一覧へ戻す' do
    assert_no_text 'Vueの学習'
    click_on '完了済みのタスクを表示'
    assert_text 'Vueの学習'

    click_on 'check_box', match: :first
    assert_text 'Vueの学習'
  end

  test 'タスクを削除する' do
    assert_no_text 'Vueの学習'
    click_on '完了済みのタスクを表示'
    assert_text 'Vueの学習'

    click_on 'delete'
    assert_no_text 'Vueの学習'
  end
end
