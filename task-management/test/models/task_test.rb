require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.create(title: "test task")
  end
  
  test "should be vaild" do
    assert @task.valid?
  end

  test "title should be present" do
    @task.title = " "
    assert_not @task.valid?
  end

  # titleの最大文字数(70文字)のバリデーションをチェック
  test "title should be at most 70 characters" do
    @task.title = "a" * 71
    assert_not @task.valid?
  end
end
