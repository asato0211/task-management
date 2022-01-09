import { shallowMount } from '@vue/test-utils'
import Todo from '../../app/javascript/packs/components/todo'
  
let wrapper = shallowMount(Todo)

describe('入力フォームのテスト', () => {
  test('タスク入力フォームが存在することを担保', () => {
    const form = wrapper.findComponent('input[id="new-task-form"]')
    expect(form.exists()).toBe(true);
  })

  test('タスク作成ボタンが存在することを担保', () => {
    const button = wrapper.findComponent('button[id="create-btn"]');
    expect(button.exists()).toBe(true);
  })
  
  test('入力した値がフォームに反映されることを担保', () => {
    wrapper.findComponent('input[id="new-task-form"]').setValue('入力テスト')
    expect(wrapper.vm.newTask).toBe('入力テスト')
  })

  test('ボタンクリックでcreateTaskが呼ばれることを担保', () => {
    const mock = jest.fn()
    wrapper.setMethods({ createTask: mock })
    wrapper.findComponent('button[id="create-btn"]').trigger('click')
    expect(mock).toBeCalled()
  })
})


describe('タスク一覧画面のテスト', () => {
  beforeEach(() => {
    wrapper.setData({
      tasks: [
        { id: 1, title: "タスク一覧のテスト", done: false }
      ],
      doneTasks: [
        { id: 2, title: "完了済みタスクのテスト", done: true }
      ]
    })
  })

  test('タスク一覧が表示されることを担保', () => {
    const notDoneTask = wrapper.findComponent('span')
    expect(notDoneTask.text()).toBe('タスク一覧のテスト')
  })
  
  test('ボタンクリックで未完了タスク一覧が表示されることを担保', () => {
    const doneTask = wrapper.findComponent('span[class="margin-of-button-and-title"]')
    wrapper.vm.displayFinishedTasks()
    expect(doneTask.text()).toBe('完了済みタスクのテスト')
  })
  
  test('完了済み一覧に移動するボタンが存在することを担保', () => {
    const button = wrapper.findComponent('button[id="move-done-tasks-btn"]');
    expect(button.exists()).toBe(true);
  })

  test('ボタンクリックでdoneTaskが呼ばれることを担保', () => {
    const mock = jest.fn()
    wrapper.setMethods({ doneTask: mock })
    wrapper.findComponent('button[id="move-done-tasks-btn"]').trigger('click')
    expect(mock).toBeCalled()
  })

  test('未完了タスク一覧に戻すボタンが存在することを担保', () => {
    const button = wrapper.findComponent('button[id="return-tasks-btn"]');
    expect(button.exists()).toBe(true);
  })

  test('ボタンクリックでnotDoneTaskが呼ばれることを担保', () => {
    const mock = jest.fn()
    wrapper.setMethods({ notDoneTask: mock })
    wrapper.findComponent('button[id="return-tasks-btn"]').trigger('click')
    expect(mock).toBeCalled()
  })

  test('削除ボタンが存在することを担保', () => {
    const button = wrapper.findComponent('button[id="delete-task-btn"]');
    expect(button.exists()).toBe(true);
  })

  test('ボタンクリックでdeleteTaskが呼ばれることを担保', () => {
    const mock = jest.fn()
    wrapper.setMethods({ deleteTask: mock })
    wrapper.findComponent('button[id="delete-task-btn"]').trigger('click')
    expect(mock).toBeCalled()
  })
})
