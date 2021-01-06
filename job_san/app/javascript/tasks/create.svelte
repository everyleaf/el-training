<script>
    import axios from "axios";
    import {
        TextInput,
        Checkbox
    } from "carbon-components-svelte";

    const taskStatuses = {
        todo: "未着手",
        doing: "着手中",
        done: "完了"
    }
    let task = {};
    const createTask = () => {
        axios.post("/api/tasks",{
            task: {
                name: taskName,
                description: description,
                target_date: targetDate,
                status: taskStatus,
            }
        }).then(() => {
            document.cookie = "_job_san_session=; max-age=0"
            alert("タスクを作成しました")
            Turbolinks.visit("/tasks")
        }).catch(e => alert(e))
    }
    let inputTargetDate = false;
    let targetDate = null;
    let validationError = " ";
    let description = "";
    let taskName = "";
    let taskStatus = "todo";
    const validateCreateTask = () => {
        if(taskName < 1 || taskName > 255){
            validationError = "タスク名は１文字以上２５５文字以内にしてください"
        } else if (description > 255) {
            validationError = "説明文は１文字以上２５５文字以内にしてください"
        } else {
            validationError = ""
        }
    }
</script>

<div style="width: 100%">
    <div style="width: 640px;margin: auto;">
        <TextInput labelText="タスク名" placeholder="サンプルタスク" bind:value={taskName} on:change={validateCreateTask}/>
        <TextInput labelText="説明文" placeholder="サンプル説明文" bind:value={description} on:change={validateCreateTask}/>
    </div>
    <div style="width: 640px;margin: auto;">
        ステータス:
        <select bind:value={taskStatus}>
            {#each Object.entries(taskStatuses) as [key, value]}
                <option value={key}>{value}</option>
            {/each}
        </select>
        <Checkbox labelText="完了日を入力"  bind:checked={inputTargetDate}/>
        {#if inputTargetDate}
            完了日:
            <input type="date" bind:value={targetDate}>
        {/if}
    </div>
    <div style="text-align-last: center;">
        <p style="color: red">{validationError}</p>
        {#if validationError.length < 1}
            <button on:click={createTask} style="padding: 20px">作成</button>
        {:else}
            <button disabled style="padding: 10px 40px">作成</button>
        {/if}
    </div>
</div>
