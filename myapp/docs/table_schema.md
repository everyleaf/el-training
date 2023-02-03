# テーブル定義書

## ・users
has_many->tasks  
  
### table
| 論理名 | 物理名 | type | PK | FK | default | not null | 備考 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  ID  | int | ○ | - | AUTO_INC | × | |
| name | 名前 | varchar | - | - | - | × | |
| email | メールアドレス | varchar | - | - | - | × | |
| encrypted_password | パスワード | varchar | - | - | - | × | hashed |
| created_at | 作成時刻 | datetime | - | - | - | × |  |
| updated_at | 更新時刻 | datetime | - | - | - | × |  |
| deleted_at | 退会時刻 | datetime | - | - | null | ○ |  |

### index
| インデックス名 | カラム | フィールド番号 
| ---- | ---- | ---- |
| index_users_on_name | name | 1 |
| index_users_on_email | email | 1 |

## ・tasks
belongs_to->users  
has_many->tasks_labels  
  
### table
| 論理名 | 物理名 | type | PK | FK | default | not null | 備考 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  ID  | int | ○ | - | AUTO_INC | × | |
| owner_id | タスク登録ユーザID | int | - | users.id | - | × | |
| status | ステータス | varchar | - | - | - | × | ["waiting", "doing", "completed"] | 
| title | タスク名 | varchar | - | - | - | × | |
| priority | タスク優先度 | tiny int | - | - | - | × | {1: "high", 2: "middle", 3: "low"} |
| description | タスクの説明文 | text | - | - | - | × | |
| expires_at | タスク終了時刻 | datetime | - | - | null | ○ |  |
| created_at | 作成時刻 | datetime | - | - | - | × |  |
| updated_at | 更新時刻 | datetime | - | - | - | × |  |
| deleted_at | 削除時刻 | datetime | - | - | null | ○ |  |

### index
| インデックス名 | カラム | フィールド番号 
| ---- | ---- | ---- |
| index_tasks_on_owner_id | owner_id | 1 |
| index_tasks_on_owner_id_and_status | owner_id | 1 |
| index_tasks_on_owner_id_and_status | status | 2 |
| index_tasks_on_owner_id_and_title | owner_id | 1 |
| index_tasks_on_owner_id_and_title | title | 2 |
| index_tasks_on_owner_id_and_priority | owner_id | 1 |
| index_tasks_on_owner_id_and_priority | priority | 2 |
| index_tasks_on_owner_id_and_expires_at | owner_id | 1 |
| index_tasks_on_owner_id_and_expires_at | expires_at | 2 |
| index_tasks_on_owner_id_and_status_and_expire_at | owner_id | 1 |
| index_tasks_on_owner_id_and_status_and_expire_at | status | 2 |
| index_tasks_on_owner_id_and_status_and_expire_at | expires_at | 3 |
| index_tasks_on_owner_id_and_status_and_priority | owner_id | 1 |
| index_tasks_on_owner_id_and_status_and_priority | status | 2 |
| index_tasks_on_owner_id_and_status_and_priority | priority | 3 |

## ・labels
has_many->tasks_labels  
  
### table
| 論理名 | 物理名 | type | PK | FK | default | not null | 備考 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  ID  | int | ○ | - | AUTO_INC | × | |
| name | ラベル名 | varchar | - | - | - | × | |
| created_at | 作成時刻 | datetime | - | - | - | × |  |
| updated_at | 更新時刻 | datetime | - | - | - | × |  |
| deleted_at | 削除時刻 | datetime | - | - | null | ○ |  |

### index
| インデックス名 | カラム | フィールド番号 
| ---- | ---- | ---- |
| index_labels_on_name | name | 1 |

## ・tasks_labels 
belongs_to->tasks  
belongs_to->labels
  
### table
| 論理名 | 物理名 | type | PK | FK | default | not null | 備考 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  ID  | int | ○ | - | AUTO_INC | × | |
| task_id | タスクID | int | - | tasks.id | - | × | |
| label_id | ラベルID | int | - | labels.id | - | × | |
| created_at | 作成時刻 | datetime | - | - | - | × |  |
| updated_at | 更新時刻 | datetime | - | - | - | × |  |

### index
| インデックス名 | カラム | フィールド番号 
| ---- | ---- | ---- |
| index_tasks_labels_on_task_id | task_id | 1 |
| index_tasks_labels_on_label_id | label_id | 1 |