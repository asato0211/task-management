<template>
  <div>
    <!-- タスク新規作成 -->
    <div class="row margin-default">
      <div class="col s10 m11">
        <input v-model="newTask" id="new-task-form" class="form-control padding-default" placeholder="タスクを追加してください!">
      </div>
      <div class="col s2 m1">
        <button class="btn-floating waves-effect waves-light red" @click="createTask">
          <i class="material-icons">add</i>
        </button>
      </div>
    </div>
    
    <!-- タスク一覧を表示 -->
    <div>
      <ul class="collection">
        <li
        :id="'row_task_' + task.id"
        class="collection-item"
        v-for="task in tasks"
        v-if="!task.done">
          <label :for="'task_' + task.id">
            <span class="word-color-black margin-of-button-and-title" :id="'task_' + task.id" >{{ task.title }}</span>
            <!-- 完了済みタスク一覧に移動するボタン -->
            <button class="waves-light btn-small check-btn" @click="doneTask(task.id)">
            <i class="material-icons">check_box_outline_blank</i>
            </button>
          </label>
        </li>
      </ul>
    </div>

    <!-- 完了済みタスクを表示するボタン -->
    <button class="btn disp-btn" @click="displayFinishedTasks">完了済みのタスクを表示</button>
    
    <!-- 完了済みタスク一覧 -->
    <div class="finished-tasks" :class="{ 'display-none': clicked }">
      <ul class="collection">
        <li
        :id="'row_task_' + task.id"
        class="collection-item"
        v-for="task in doneTasks"
        v-if="task.done">
          <label :for="'task_' + task.id">
            <span class="margin-of-button-and-title" :id="'task_' + task.id" >{{ task.title }}</span>
            <!-- 未完了タスク一覧に戻すボタン -->
            <button class="waves-effect waves-light btn-small check-btn" @click="notDoneTask(task.id)">
            <i class="material-icons">check_box</i>
            </button>
            <!-- 削除ボタン -->
            <button class="waves-effect waves-light btn-small delete-btn" @click="deleteTask(task.id)">
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
        newTask: '',
        clicked: true
      }
    },

    // インスタンスがマウントされたタイミングで実行(ライフサイクルダイアグラム)
    mounted() {
      this.fetchTasks();
    },

    methods: {
      // APIで取得した値をdataに格納する(tasks=未完了タスク、doneTasks=完了済みタスク)
      async fetchTasks() {
        try {
          const response = await axios.get('/api/v1/tasks')
          const resTasks = response.data.tasks
          resTasks.forEach((resTask) => {
            if (resTask.done) {
              this.doneTasks.push(resTask)
            }else{
              this.tasks.push(resTask);
            };
          });
        }catch(e) {
          console.log(e);
        }
      },

      // 新規タスクを追加
      async createTask() {
        try {
          if (!this.newTask) return;
          const response = await axios.post('/api/v1/tasks', { task: { title: this.newTask } })
          this.tasks.unshift(response.data.task);
          this.newTask = '';
        }catch(e) {
          console.log(e);
        }
      },

      // 完了済みタスク一覧に移動
      async doneTask(task_id) {
        try {
          const response = await axios.put('/api/v1/tasks/' + task_id, { task: { done: true } })
          const index = this.tasks.findIndex((task) => task.id === task_id);
          this.doneTasks.unshift(response.data.task);
          this.tasks.splice(index,1)
        }catch(e) {
          console.log(e);
        }
      },

      // ボタン→完了済みタスク一覧を表示する(デフォルトは非表示)
      displayFinishedTasks() {
        if (this.clicked) {
          this.clicked = false
        }else{
          this.clicked = true
        }
      },

      // 未完了タスク一覧に戻す
      async notDoneTask(task_id) {
        try {
          const response = await axios.put('/api/v1/tasks/' + task_id, { task: { done: false } })
          const index = this.doneTasks.findIndex((task) => task.id === task_id);
          this.tasks.unshift(response.data.task);
          this.doneTasks.splice(index,1);
        }catch(e) {
          console.log(e);
        }
      },

      // タスクを削除(完了済み一覧から)
      async deleteTask(task_id) {
        try {
          await axios.delete('/api/v1/tasks/' + task_id, { task: { done: false } })
          const index = this.doneTasks.findIndex((task) => task.id === task_id);
          this.doneTasks.splice(index, 1);
        }catch(e) {
          console.log(e);
        }
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
