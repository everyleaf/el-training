import TaskIndex from '../tasks/index.svelte';
import JobsanHeader from '../jobsanHeader.svelte';
import TaskCreate from '../tasks/create.svelte';

document.addEventListener('turbolinks:visit', () => {
  if(window.app) {
    window.app.$destroy();
    window.app = null;
  }
});

document.addEventListener('turbolinks:load', () => {
  let apps = [{ elem: document.getElementById("task_index"), object: TaskIndex },
      { elem: document.getElementById("task_create"), object: TaskCreate },
      { elem: document.getElementById("jobsan_header"), object: JobsanHeader }];
  let props = window.jsProps || {}

  apps.forEach(app => {
      if(app.elem){
          window.app = new app.object({ target: app.elem, props });
      }
    });
});
