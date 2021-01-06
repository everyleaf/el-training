<script>
  import "carbon-components-svelte/css/all.css";
  import { onMount } from "svelte";
  import axios from "axios";
  import InfiniteScroll from "svelte-infinite-scroll";
  import moment from "moment";
  import {
    Search,
    Button,
    Grid,
    Row,
    Column,
    Select,
    SelectItem,
    ComposedModal,
    ModalHeader,
    ModalBody,
    ModalFooter,
    TextInput,
  } from "carbon-components-svelte";

  let [tasks, fetchedTasks] = [[], []];
  let searchName, loading, sortKey, sortOrder;
  let searchStatus = "";
  $: tasks = [...tasks, ...fetchedTasks];
  $: fetchedTasks = [];
  let task = {};
  let searchPage = 1;
  let updateModalOpen = false;

  function viewedTaskName(_name) {
    return _name.length > 10 ? `${_name.substring(0, 9)}...` : _name;
  }
  const viewedTaskTargetDate = (_targetDate) => _targetDate || "未設定";
  const viewedTaskCreatedAt = (_createdAt) =>
    moment(_createdAt).format("YYYY年MM月DD日");
  function openModal(_task) {
    validationError = "";
    task = _task;
    updateModalOpen = true;
  }

  function loadTasks() {
    searchPage++;
    fetchTasks();
  }

  $: loading = false;
  $: sortKey = "created_at";
  $: sortOrder = "desc";
  const taskStatuses = {
    todo: "未着手",
    doing: "着手中",
    done: "完了",
  };

  onMount(() => {
    fetchTasks();
    updateModalOpen = false;
  });

  function fetchTasks() {
    axios
      .get("/api/tasks/search", {
        params: {
          query: {
            name_cont: searchName,
            status_eq: searchStatus,
            s: `${sortKey} ${sortOrder}`,
          },
          page: searchPage,
        },
      })
      .then((res) => {
        fetchedTasks = res.data;
      })
      .catch((e) => alert(e))
      .finally(() => (loading = false));
  }

  function initFetchTasks() {
    fetchedTasks = [];
    tasks = [];
    searchPage = 1;
    loading = true;
    fetchTasks();
  }

  function sortTasksBy(_sortKey) {
    sortKey = _sortKey;
    sortOrder = sortOrder === "desc" ? "asc" : "desc";
    initFetchTasks();
  }

  $: viewedSortedMark = (_sortKey) => {
    if (sortKey === _sortKey) {
      return sortOrder === "desc" ? "☝️" : "️👇";
    } else {
      return "";
    }
  };

  const updateTask = () => {
    axios
      .put(`/api/tasks/${task.id}`, {
        task: task,
      })
      .then((res) => {
        const updatedTaskIndex = tasks.findIndex((t) => t.id === task.id);
        if (updatedTaskIndex > -1) {
          tasks[updatedTaskIndex] = task;
        }
        alert(res.data.message);
      })
      .catch((e) => {
        alert(e.data.message);
      })
      .finally(() => (updateModalOpen = false));
  };

  const deleteTask = (event, task) => {
    event.stopPropagation();
    if (confirm(`${task.name}を削除しますか？`)) {
      axios
        .delete(`/api/tasks/${task.id}`)
        .then((res) => {
          const deletedTaskIndex = tasks.findIndex((t) => t.id === task.id);
          if (deletedTaskIndex > -1) {
            tasks[deletedTaskIndex] = null;
            tasks = tasks.filter((t) => t);
          }
          alert(res.data.message);
        })
        .catch((e) => {
          alert(e.data.message);
        });
    }
    updateModalOpen = false;
  };
  let updateModalChecked = true;
  let validationError = "";
  const validateUpdateTask = () => {
    if (task.name < 1 || task.name > 255) {
      updateModalChecked = false;
      validationError = "タスク名は１文字以上２５５文字以下に設定してください";
    } else if (task.description > 255) {
      updateModalChecked = false;
      validationError = "説明文は２５５文字以下に設定してください";
    } else {
      updateModalChecked = true;
      validationError = "";
    }
  };
</script>

<Grid padding>
  <Row>
    <Column>
      <Search placeholder="タスク名" bind:value={searchName} />
    </Column>
    <Column>
      <Select inline labelText="ステータス" bind:selected={searchStatus}>
        <SelectItem value="" text="全てのステータス" />
        {#each Object.entries(taskStatuses) as [key, value]}
          <SelectItem value={key} text={value} />
        {/each}
      </Select>
    </Column>
    <Column>
      <Button on:click={initFetchTasks}>検索</Button>
    </Column>
  </Row>
</Grid>

{#if loading}
  <div>ロードしています。</div>
{:else if tasks.length < 1}
  <div>検索結果が見つかりませんでした。</div>
{/if}

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
    {#each tasks as task}
      <tr
        id={task.id}
        on:click={() => openModal(task)}
        on:mouseover={(e) => {
          e.currentTarget.style.backgroundColor = '#0f62fe';
          e.currentTarget.style.color = 'white';
        }}
        on:mouseout={(e) => {
          e.currentTarget.style.backgroundColor = 'white';
          e.currentTarget.style.color = 'black';
        }}
        style="cursor: pointer;">
        <td>{task.id}</td>
        <td>{viewedTaskName(task.name)}</td>
        <td style="text-align: -webkit-center;">{taskStatuses[task.status]}</td>
        <td>{viewedTaskTargetDate(task.target_date)}</td>
        <td style="text-align: -webkit-center;">
          {viewedTaskCreatedAt(task.created_at)}
        </td>
        <td
          on:click={(e) => deleteTask(e, task)}
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

<ComposedModal
  open={updateModalOpen}
  on:submit={updateTask}
  on:close={() => (updateModalOpen = false)}>
  <ModalHeader title="タスクの詳細" />
  <ModalBody hasForm>
    <p>ID: {task.id}</p>
    <TextInput
      labelText="タスク名"
      placeholder="サンプルタスク"
      bind:value={task.name}
      on:change={validateUpdateTask} />
    <TextInput
      labelText="説明文"
      placeholder="サンプル説明文"
      bind:value={task.description}
      on:change={validateUpdateTask} />
    完了日：<input type="date" bind:value={task.target_date} />
    <Select inline labelText="ステータス" bind:selected={task.status}>
      {#each Object.entries(taskStatuses) as [key, value]}
        <SelectItem value={key} text={value} />
      {/each}
    </Select>

    <p style="color: red;">{validationError}</p>
  </ModalBody>
  <ModalFooter
    primaryButtonText="Proceed"
    primaryButtonDisabled={!updateModalChecked} />
</ComposedModal>

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
