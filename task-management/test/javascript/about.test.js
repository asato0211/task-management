import { mount } from '@vue/test-utils'
import About from '../../app/javascript/packs/components/about'

  // jest導入のテスト
  test('概要ページのテスト', () => {
    const wrapper = mount(About)
    expect(wrapper.text()).toBe('RailsとVueのサンプルアプリケーションです。 Github : https://github.com/asato0211/task-management')
  })
