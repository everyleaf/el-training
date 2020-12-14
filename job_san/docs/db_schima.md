### users

ユーザテーブル

| name | type | null | remarks |
|:-----------|:------------|:------|:-------------|
|id|INT|NO|PK AUTO_INCREMENT|
|name|VARCHAR(255)|NO||
|email|VARCHAR(255)|NO||
|password|VARCHAR(255)|NO||
|created_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP|
|updated_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP|
|deleted_at|TIMESTAMP|YES|論理削除用|

### labels

タスクのラベル用のテーブル

| name | type | null | remarks |
|:-----------|:------------|:------|:-------------|
|id|INT|NO|PK AUTO_INCREMENT|
|name|VARCHAR(100)|NO|UNIQUE|
|created_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP|
|updated_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP|

### tasks

タスクテーブル

| name | type | null | remarks |
|:-----------|:------------|:------|:-------------|
|id|INT|NO|PK AUTO_INCREMENT|
|name|VARCHAR(255)|NO||
|description|VARCHAR(255)|NO||
|priority|VARCHAR(6)|NO|CHECK(`priority` IN(`hight`, `midium`, `low`))|
|status|VARCHAR(5)|NO|CHECK(`status` IN(`todo`, `doing`, `done`))|
|user_id|INT|NO|FK: users|
|label_id|INT|YES|FK: labels|
|created_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP|
|updated_at|TIMESTAMP|YES|DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP|
|complete_at|DATE|YES||