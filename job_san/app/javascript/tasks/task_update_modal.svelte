<script>
  import {
    ComposedModal,
    ModalHeader,
    ModalBody,
    ModalFooter,
  } from "carbon-components-svelte";
  import axios from "axios";

  export let taskStatuses = {};
  export let tasks = [];
  export let task = {};
  export let updateModalOpen = true;
  let updateModalChecked = true;
  let validationError = "";

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

<ComposedModal open={updateModalOpen} on:submit={updateTask}>
  <ModalHeader title="タスクの詳細" />
  <ModalBody hasForm>
    <p>ID: {task.id}</p>
    <input type="text" bind:value={task.name} on:change={validateUpdateTask} />
    <input
      type="text"
      bind:value={task.description}
      on:change={validateUpdateTask} />
    <input type="date" bind:value={task.target_date} />
    <select bind:value={task.status}>
      {#each Object.entries(taskStatuses) as [key, value]}
        <option value={key}>{value}</option>
      {/each}
    </select>

    <p style="color: red;">{validationError}</p>
  </ModalBody>
  <ModalFooter
    primaryButtonText="Proceed"
    primaryButtonDisabled={!updateModalChecked} />
</ComposedModal>
