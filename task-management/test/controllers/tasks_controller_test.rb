require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "indexアクションのレスポンステスト" do
    get "/api/v1/tasks", as: :json
    assert_response :success
  end

  test "createアクションのレスポンステスト" do
    assert_difference('Task.count') do
      post "/api/v1/tasks", params: { task: { title: @task.title, done: @task.done } }, as: :json
    end

    assert_response :created
  end

  test "updateアクションのレスポンステスト" do
    patch "/api/v1/tasks/1", params: { task: { title: @task.title, done: @task.done } }, as: :json
    assert_response :ok
  end

  test "destroyアクションのレスポンステスト" do
    assert_difference('Task.count', -1) do
      delete "/api/v1/tasks/1", as: :json
    end

    assert_response :ok
  end  
end
