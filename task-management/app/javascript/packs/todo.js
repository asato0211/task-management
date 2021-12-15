import Vue from 'vue/dist/vue.esm.js'
import Header from './components/header.vue'

const app = new Vue({
  el: '#app',
  components: {
    'navbar': Header,
  }
});