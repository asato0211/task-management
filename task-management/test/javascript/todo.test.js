import { shallowMount } from '@vue/test-utils'
import Todo from '../../app/javascript/packs/components/todo'
  
let wrapper
beforeEach(() => {
  wrapper = shallowMount(Todo)
})

describe('入力フォームのテスト', () => {
  beforeEach(() => {
    wrapper.find('input[id="new-task-form"]').setValue('入力テスト')
  })
  
  test('タスク入力フォームが存在することを担保', () => {
    const form = wrapper.find('input[id="new-task-form"]')
    expect(form.exists()).toBe(true);
  })

  test('タスク作成ボタンが存在することを担保', () => {
    const button = wrapper.find('button[id="create-btn"]');
    expect(button.exists()).toBe(true);
  })    
  
  test('入力した値がフォームに反映されることを担保', () => {
    expect(wrapper.vm.newTask).toBe('入力テスト')
  })

  test('ボタンクリックでcreateTaskが呼ばれることを担保', () => {
    const mock = jest.fn()
    wrapper.setMethods({ createTask: mock })
    wrapper.find('button[id="create-btn"]').trigger('click')
    expect(mock).toBeCalled()
  })
})
