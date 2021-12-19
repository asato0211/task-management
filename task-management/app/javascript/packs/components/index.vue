<template>
  <div>
    <!-- タスク新規作成 -->
    <div class="row margin-default">
      <div class="col s10 m11">
        <input v-model="newTask" id="new-task-form" class="form-control padding-default" placeholder="タスクを追加してください!">
      </div>
      <div class="col s2 m1">
        <button class="btn-floating waves-effect waves-light red" v-on:click="createTask">
          <i class="material-icons">add</i>
        </button>
      </div>
    </div>
    
    <!-- タスク一覧を表示 -->
    <div>
      <ul class="collection">
        <li
        v-bind:id="'row_task_' + task.id"
        class="collection-item"
        v-for="task in tasks"
        v-if="!task.done">
          <label v-bind:for="'task_' + task.id">
            <input type="checkbox" v-bind:id="'task_' + task.id" v-on:change="doneTask(task.id)" />
            <span>
              <label class="word-color-black">{{ task.title }}</label>
            </span>
          </label>
        </li>
      </ul>
    </div>

    <!-- 完了済みタスクを表示するボタン -->
    <button class="btn btn-custom" v-on:click="displayFinishedTasks">完了済みのタスクを表示</button>
    
    <!-- 完了済みタスク一覧 -->
    <div id="finished-tasks" class="display_none">
      <ul class="collection">
        <li
        v-bind:id="'row_task_' + task.id"
        class="collection-item"
        v-for="task in tasks"
        v-if="task.done">
          <label v-bind:for="'task_' + task.id">
            <input type="checkbox" v-bind:id="'task_' + task.id" checked="checked"/>
            <span>
              <label class="line-through">{{ task.title }}</label>
            </span>
          </label>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        tasks: [],
        newTask: ''
      }
    },

    // インスタンスがマウントされたタイミングで実行(ライフサイクルダイアグラム)
    mounted() {
      this.fetchTasks();
    },   

    methods: {
      // APIで取得した値をtasksに格納する
      fetchTasks() {
        axios.get('/api/tasks').then((response) => {
          for(let i = 0; i < response.data.tasks.length; i++) {
            this.tasks.push(response.data.tasks[i]);
          }
        }, (error) => {
          console.log(error);
        });
      },

      // 新規タスクを追加
      createTask() {
        if (!this.newTask) return;
        axios.post('/api/tasks', { task: { title: this.newTask } }).then((response) => {
          this.tasks.unshift(response.data.task);
          this.newTask = '';
        }, (error) => {
          console.log(error);
        });
      },

      // 完了済みタスク一覧を表示する
      doneTask(task_id) {
        axios.put('/api/tasks/' + task_id, { task: { done: true } }).then((response) => {
          this.moveFinishedTask(task_id);
        }, (error) => {
          console.log(error);
        });
      },

      // タスク一覧→チェックボックスを押した際に動作する
      displayFinishedTasks() {
        document.querySelector('#finished-tasks').classList.toggle('display_none');
      },

      // 完了済みタスク一覧に移動
      moveFinishedTask(task_id) {
        const el = document.querySelector('#row_task_' + task_id);
        // DOMをクローンしておく
        const el_clone = el.cloneNode(true);  // DOMをクローンしておく
        el.classList.add('display_none');     // 未完了のタスクを先に非表示にする
        // スタイルをあてて完了済みタスク一覧に追加する
        el_clone.getElementsByTagName('input')[0].checked = 'checked';
        el_clone.getElementsByTagName('label')[0].classList.add('line-through');
        el_clone.getElementsByTagName('label')[0].classList.remove('word-color-black');
        const li = document.querySelector('#finished-tasks > ul > li:first-child');
        document.querySelector('#finished-tasks > ul').insertBefore(el_clone, li);
      }
    }
  }
</script>

<style scoped>
  [v-cloak] {
    display: none;
  }
  .margin-default {
    margin-top: 30px;
  }
  .padding-default {
    padding-left: 20px;
  }
  .word-color-black {
    color: #000000;
  }
  .collection-item:hover {
    background-color: #ddd;
  }
  .display_none {
    display:none;
  }
  .line-through {
    text-decoration: line-through;
  }
  .btn-custom {
    text-transform: none;
    padding: 0 10px;
    font-size: 0.8rem;
    background-color: white;
    color: black;
    border-color: black;
  }
</style>
