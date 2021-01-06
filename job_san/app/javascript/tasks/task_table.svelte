<script>
  import moment from "moment";
  import axios from "axios";
  import InfiniteScroll from "svelte-infinite-scroll";
  import {
    updateModalOpen,
    task,
    tasks,
    searchPage,
    sortKey,
    sortOrder,
  } from "./store.js";

  function viewedTaskName(_name) {
    return _name.length > 10 ? `${_name.substring(0, 9)}...` : _name;
  }
  export let taskStatuses, initFetchTasks, fetchTasks, fetchedTasks;
  const viewedTaskTargetDate = (_targetDate) => _targetDate || "未設定";
  const viewedTaskCreatedAt = (_createdAt) =>
    moment(_createdAt).format("YYYY年MM月DD日");
  function openModal(_task) {
    $task = _task;
    $updateModalOpen = true;
  }
  function loadTasks() {
    $searchPage++;
    fetchTasks();
  }

  function sortTasksBy(_sortKey) {
    $sortKey = _sortKey;
    $sortOrder = $sortOrder === "desc" ? "asc" : "desc";
    initFetchTasks();
  }

  $: viewedSortedMark = (_sortKey) => {
    if ($sortKey === _sortKey) {
      return $sortOrder === "desc" ? "☝️" : "️👇";
    } else {
      return "";
    }
  };

  const deleteTask = (event, _task) => {
    event.stopPropagation();
    if (confirm(`${_task.name}を削除しますか？`)) {
      axios
        .delete(`/api/tasks/${_task.id}`)
        .then((res) => {
          const deletedTaskIndex = $tasks.findIndex((t) => t.id === _task.id);
          if (deletedTaskIndex > -1) {
            $tasks[deletedTaskIndex] = null;
            $tasks = $tasks.filter((t) => t);
          }
          alert(res.data.message);
        })
        .catch((e) => {
          alert(e.data.message);
        });
    }
    $updateModalOpen = false;
  };
</script>

<table style="width: 100%; border: solid;">
  <thead style="border: solid 1px">
    <tr>
      <th>ID</th>
      <th>タスク名</th>
      <th>ステータス</th>
      <th
        on:click={() => sortTasksBy('target_date')}
        style="cursor: pointer; background: wheat;"
        on:mouseover={(e) => {
          e.currentTarget.style.backgroundColor = 'burlywood';
        }}
        on:mouseout={(e) => {
          e.currentTarget.style.backgroundColor = 'wheat';
        }}>
        完了日{viewedSortedMark('target_date')}
      </th>
      <th
        on:click={() => sortTasksBy('created_at')}
        style="cursor: pointer; background: wheat;"
        on:mouseover={(e) => {
          e.currentTarget.style.backgroundColor = 'burlywood';
        }}
        on:mouseout={(e) => {
          e.currentTarget.style.backgroundColor = 'wheat';
        }}>
        作成日{viewedSortedMark('created_at')}
      </th>
      <th>🗑</th>
    </tr>
  </thead>
  <tbody>
    {#each $tasks as _task}
      <tr
        id={_task.id}
        on:click={() => openModal(_task)}
        on:mouseover={(e) => {
          e.currentTarget.style.backgroundColor = '#0f62fe';
          e.currentTarget.style.color = 'white';
        }}
        on:mouseout={(e) => {
          e.currentTarget.style.backgroundColor = 'white';
          e.currentTarget.style.color = 'black';
        }}
        style="cursor: pointer;">
        <td>{_task.id}</td>
        <td>{viewedTaskName(_task.name)}</td>
        <td style="text-align: -webkit-center;">
          {taskStatuses[_task.status]}
        </td>
        <td>{viewedTaskTargetDate(_task.target_date)}</td>
        <td style="text-align: -webkit-center;">
          {viewedTaskCreatedAt(_task.created_at)}
        </td>
        <td
          on:click={(e) => deleteTask(e, _task)}
          style="text-align: -webkit-center;">
          ❌
        </td>
      </tr>
    {/each}
    <InfiniteScroll
      hasMore={fetchedTasks.length}
      threshold={10}
      window={true}
      on:loadMore={loadTasks} />
  </tbody>
</table>

<style>
  th {
    border: solid;
    padding: 10px;
  }
  td {
    border-left: solid;
    padding: 10px;
  }
</style>
