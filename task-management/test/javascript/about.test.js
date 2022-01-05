import { shallowMount } from '@vue/test-utils'
import About from '../../app/javascript/packs/components/about'

test('概要ページのテスト', () => {
  const wrapper = shallowMount(About)
  expect(wrapper.text()).toBe('RailsとVueのサンプルアプリケーションです。 Github : https://github.com/asato0211/task-management')
})
