<script>
    import "carbon-components-svelte/css/all.css";
    import axios from 'axios';
    import { ContentSwitcher, Switch } from "carbon-components-svelte";
    export var loggedIn;
    const redirectTo = _path => location.href = _path
    function logout() {
        axios.delete("/api/logout",{})
            .then(() => {
                document.cookie = "_job_san_session=; max-age=0"
                location.href = "/login"
            }).catch(e => alert(e))}
    const isAdmin = () => location.href.includes("/admin")
    const fetchSelectedIndex = () => location.href.endsWith("/new") ? 1 : 0
</script>

<h1>Job San</h1>
{#if loggedIn}
    <div>
        <ContentSwitcher selectedIndex={fetchSelectedIndex()}>
            {#if isAdmin()}
                <Switch on:click={()=>redirectTo("/admin/users")} text="ユーザ一覧" />
                <Switch on:click={()=>redirectTo("/admin/users/new")} text="ユーザ作成" />
            {:else}
                <Switch on:click={()=>redirectTo("/tasks")} text="タスク一覧" />
                <Switch on:click={()=>redirectTo("/tasks/new")} text="タスク作成" />
            {/if}
            <Switch on:click={logout} text="ログアウト" />
        </ContentSwitcher>
    </div>
{/if}

