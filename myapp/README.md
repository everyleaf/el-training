# Database

## user table

| Column             | Type    | Options                   |
|--------------------|---------|---------------------------|
|  name              | string  | null: false               |
|  email             | string  | null: false, unique: true |
|  password_digest   | string  | null: false               |
|  remenber_token    | string  | null: false               |

### Assciation

- has_many : user_tasks
- has_many : tasks, through: :user_tasks

## user_task table

| Column   | Type        | Options                        |
|----------|-------------|--------------------------------|
|  user_id | references  | null: false, foreign_key: true |
|  task_id | references  | null: false, foreign_key: true |

### Assciation

- belongs_to : task
- belongs_to : user

## task table

| Column             | Type    | Options     |
|--------------------|---------|-------------|
|  title             | string  | null: false |
|  outline           | string  | null: false |
|  task_limit        | data    | null: false |
|  task_status_id    | integer | null: false |
|  task_priority_id  | integer | null: false |

### Assciation

- has_many : user_tasks
- has_many : users, through: :user_tasks
- belongs_to : task_statustask_priority_id
- belongs_to : task_priority_id