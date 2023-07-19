## Todos Application
It is a Task Management app that does following key features

## A USER 
- can login/logout
- can change task status
- can see tasks assigned to him by admin

## A USER (as Admin)
- can Create/Update/Delete/List USERS or ADMIN
- can Create/Update/Delete/List Tasks
- can Set due date to task
- Set status to task
- Delete task
- add labels
- Assign/Unassign user to task


## Table Schema
### users

|  column  |  type  |
| ---- | ---- |
|  id  |  int  |
|  first_name  |  string  |
|  last_name  |  string  |
|  password  |  string  |
|  email  |  string  |
|  username  |  string  |
|  is_admin | bool |
|  date_of_birth | string |


### tasks

|  column  |  type  |
| ---- | ---- |
|  id  |  int  |
|  user_id  |  int  |
|  title  |  string  |
|  description  |  string  |
|  status  |  int  |
|  priority  |  int  |
|  due_date  |  datetime  |
|  assign_user_id  |  int  |
|  created_at | datetime |
|  updated_at | datetime |

### task_labels

|  colum  |  type  |
| ---- | ---- |
|  id  |  int  |
|  task_id | int |
|  label_id | int |

### labels

|  colum  |  type  |
| ---- | ---- |
|  id  |  int  |
|  name  |  string  |
|  description  |  string  |
