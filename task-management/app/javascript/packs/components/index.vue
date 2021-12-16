<template>
  <div>
    <!-- タスク新規作成部分 -->
    <div class="row">
      <div class="col s10 m11">
        <input class="form-control" placeholder="タスクを追加してください!">
      </div>
      <div class="col s2 m1">
        <div class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>
    </div>
    <!-- タスク一覧を表示 -->
    <div>
      <ul class="collection">
        <li id="row_task_1" class="collection-item">
          <label for="'task_1">
            <input type="checkbox" id="task_2" />
            <span>テスト１</span>
          </label>
        </li>
        <li id="row_task_2" class="collection-item">
          <label for="'task_2">
            <input type="checkbox" id="task_2" />
            <span>テスト２</span>
          </label>
        </li>
        <li id="row_task_3" class="collection-item">
          <label for="'task_3">
            <input type="checkbox" id="task_3" />
            <span>テスト３</span>
          </label>
        </li>
      </ul>
    </div>
    <!-- 完了したタスクを表示するボタン -->
    <div class="btn">完了したタスクを表示</div>
    <!-- 完了したタスク一覧 -->
    <div id="finished-tasks" class="display_none">
      <ul class="collection">
        <li id="row_task_4" class="collection-item">
          <label for="'task_4">
            <input type="checkbox" id="task_4" />
            <span>終了タスク１</span>
          </label>
        </li>        
        <li id="row_task_5" class="collection-item">
          <label for="'task_5">
            <input type="checkbox" id="task_5" />
            <span>終了タスク２</span>
          </label>
        </li>  
      </ul>
    </div>
  </div>
</template>