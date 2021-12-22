import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Todo from '../components/todo.vue'
import About from '../components/about.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',  // historyモード(URLの書き換え)
  routes: [
    { path: '/', component: Todo },
    { path: '/about', component: About }
  ],
})
