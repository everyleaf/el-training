<script>
  import "carbon-components-svelte/css/all.css";
  import { onMount } from "svelte";
  import axios from "axios";
  import {
    Search,
    Button,
    Grid,
    Row,
    Column,
    Select,
    SelectItem,
  } from "carbon-components-svelte";

  import TaskUpdateModal from "./task_update_modal.svelte";
  import {
    updateModalOpen,
    tasks,
    searchPage,
    sortKey,
    sortOrder,
  } from "./store.js";
  import TaskTable from "./task_table.svelte";

  let searchName;
  let searchStatus = "";
  let fetchedTasks = [];
  let loading = false;
  const taskStatuses = {
    todo: "未着手",
    doing: "着手中",
    done: "完了",
  };

  onMount(() => {
    fetchTasks();
    $updateModalOpen = false;
  });

  function fetchTasks() {
    axios
      .get("/api/tasks/search", {
        params: {
          query: {
            name_cont: searchName,
            status_eq: searchStatus,
            s: `${$sortKey} ${$sortOrder}`,
          },
          page: $searchPage,
        },
      })
      .then((res) => {
        fetchedTasks = res.data;
        $tasks = [...$tasks, ...fetchedTasks];
      })
      .catch((e) => alert(e))
      .finally(() => (loading = false));
  }

  function initFetchTasks() {
    fetchedTasks = [];
    $tasks = [];
    $searchPage = 1;
    loading = true;
    fetchTasks();
  }
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
{:else if $tasks.length < 1}
  <div>検索結果が見つかりませんでした。</div>
{/if}

<TaskTable {taskStatuses} {initFetchTasks} {fetchTasks} {fetchedTasks} />
<TaskUpdateModal {taskStatuses} />
