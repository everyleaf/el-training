#!/bin/bash
# user
# rails generate model user name:string login_id:string password:digest deleted_at:datetime
rails db:migrate
rails db:migrate:redo

# task
# rails generate model task name:string description:text user:references priority:integer status:integer due:datetime deleted_at:datetime
rails db:migrate
rails db:migrate:redo

# label
# rails generate model label name:string
rails db:migrate
rails db:migrate:redo

# task_label
# rails generate model task_label task:references label:references
rails db:migrate
rails db:migrate:redo
