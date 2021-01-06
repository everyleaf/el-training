<script>
  import axios from "axios";
  import {
    ComposedModal,
    ModalHeader,
    ModalBody,
    ModalFooter,
    TextInput,
    Select,
    SelectItem,
  } from "carbon-components-svelte";
  import { updateModalOpen, task, tasks } from "./store.js";

  export let taskStatuses = {};
  let updateModalChecked = true;
  let validationError = "";

  const updateTask = () => {
    axios
      .put(`/api/tasks/${$task.id}`, {
        task: $task,
      })
      .then((res) => {
        const updatedTaskIndex = $tasks.findIndex((t) => t.id === $task.id);
        if (updatedTaskIndex > -1) {
          $tasks[updatedTaskIndex] = $task;
        }
        alert(res.data.message);
      })
      .catch((e) => {
        alert(e.data.message);
      })
      .finally(() => ($updateModalOpen = false));
  };

  const validateUpdateTask = () => {
    if ($task.name < 1 || $task.name > 255) {
      updateModalChecked = false;
      validationError = "タスク名は１文字以上２５５文字以下に設定してください";
    } else if ($task.description > 255) {
      updateModalChecked = false;
      validationError = "説明文は２５５文字以下に設定してください";
    } else {
      updateModalChecked = true;
      validationError = "";
    }
  };

  const onClose = () => {
    validationError = "";
    $updateModalOpen = false;
  };
</script>

<ComposedModal
  open={$updateModalOpen}
  on:submit={updateTask}
  on:close={onClose}>
  <ModalHeader title="タスクの詳細" />
  <ModalBody hasForm>
    <p>ID: {$task.id}</p>
    <TextInput
      labelText="タスク名"
      placeholder="サンプルタスク"
      bind:value={$task.name}
      on:change={validateUpdateTask} />
    <TextInput
      labelText="説明文"
      placeholder="サンプル説明文"
      bind:value={$task.description}
      on:change={validateUpdateTask} />
    完了日：<input type="date" bind:value={$task.target_date} />
    <Select inline labelText="ステータス" bind:selected={$task.status}>
      {#each Object.entries(taskStatuses) as [key, value]}
        <SelectItem value={key} text={value} />
      {/each}
    </Select>

    <p style="color: red;">{validationError}</p>
  </ModalBody>
  <ModalFooter
    primaryButtonText="保存"
    primaryButtonDisabled={!updateModalChecked} />
</ComposedModal>
