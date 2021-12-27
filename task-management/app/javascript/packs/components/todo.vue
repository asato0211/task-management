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
            <span class="word-color-black margin-of-button-and-title" v-bind:id="'task_' + task.id" >{{ task.title }}</span>
            <!-- 完了済みタスク一覧に移動するボタン -->
            <button class="waves-light btn-small check-btn" v-on:click="doneTask(task.id)">
            <i class="material-icons">check_box_outline_blank</i>
            </button>
          </label>
        </li>
      </ul>
    </div>

    <!-- 完了済みタスクを表示するボタン -->
    <button class="btn disp-btn" v-on:click="displayFinishedTasks">完了済みのタスクを表示</button>
    
    <!-- 完了済みタスク一覧 -->
    <div id="finished-tasks" class="display-none">
      <ul class="collection">
        <li
        v-bind:id="'row_task_' + task.id"
        class="collection-item"
        v-for="task in doneTasks"
        v-if="task.done">
          <label v-bind:for="'task_' + task.id">
            <span class="margin-of-button-and-title" v-bind:id="'task_' + task.id" >{{ task.title }}</span>
            <!-- 未完了タスク一覧に戻すボタン -->
            <button class="waves-effect waves-light btn-small check-btn" v-on:click="notDoneTask(task.id)">
            <i class="material-icons">check_box</i>
            </button>
            <!-- 削除ボタン -->
            <button class="waves-effect waves-light btn-small delete-btn" v-on:click="deleteTask(task.id)">
            <i class="material-icons">delete</i>
            </button>            
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
        doneTasks: [],
        newTask: ''
      }
    },

    // インスタンスがマウントされたタイミングで実行(ライフサイクルダイアグラム)
    mounted() {
      this.fetchTasks();
    },   

    methods: {
      // APIで取得した値をdataに格納する(tasks=未完了タスク、doneTasks=完了済みタスク)
      fetchTasks() {
        axios.get('/api/v1/tasks').then((response) => {
          for(let i = 0; i < response.data.tasks.length; i++) {
            if (response.data.tasks[i].done) {
              this.doneTasks.push(response.data.tasks[i])
            }else{
              this.tasks.push(response.data.tasks[i]);
            };
          }
        }, (error) => {
          console.log(error);
        });
      },

      // 新規タスクを追加
      createTask() {
        if (!this.newTask) return;
        axios.post('/api/v1/tasks', { task: { title: this.newTask } }).then((response) => {
          this.tasks.unshift(response.data.task);
          this.newTask = '';
        }, (error) => {
          console.log(error);
        });
      },

      // 完了済みタスク一覧に移動
      doneTask(task_id) {
        axios.put('/api/v1/tasks/' + task_id, { task: { done: true } }).then((response) => {
          const index = this.tasks.findIndex((task) => task.id === task_id);
          this.doneTasks.unshift(response.data.task);
          this.tasks.splice(index,1)
        }, (error) => {
          console.log(error);
        });
      },

      // ボタン→完了済みタスク一覧を表示する(デフォルトは非表示)
      displayFinishedTasks() {
        document.getElementById('finished-tasks').classList.toggle('display-none');
      },

      // 未完了タスク一覧に戻す
      notDoneTask(task_id) {
        axios.put('/api/v1/tasks/' + task_id, { task: { done: false } }).then((response) => {
          const index = this.doneTasks.findIndex((task) => task.id === task_id);
          this.tasks.unshift(response.data.task);
          this.doneTasks.splice(index,1);
        }, (error) => {
          console.log(error);
        });
      },

      // タスクを削除(完了済み一覧から)
      deleteTask(task_id) {
        axios.delete('/api/v1/tasks/' + task_id, { task: { done: false } }).then((response) => {
          const index = this.doneTasks.findIndex((task) => task.id === task_id);
          this.doneTasks.splice(index, 1);
        }, (error) => {
          console.log(error, response);
        });
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
  .display-none {
    display :none;
  }
  .disp-btn {
    text-transform: none;
    padding: 0 10px;
    font-size: 0.8rem;
    background-color: #8c9eff;
    color: white;
    border-color: black;
  }
  .check-btn {
    float: left;
    padding: 0 5px;
    background-color: white;
    color: black;
  }
  .delete-btn {
    float: right;
    padding: 0 5px;
    background-color: white;
    color: red;
  }
  .margin-of-button-and-title {
    padding: 0 20px;
  }
</style>
