# training

## システム要件 設計のチェックシート
- [x] 自分のタスクを簡単に登録したい
登録画面プロトタイプ（済)
タスク一覧テーブル(済)

- [x] タスクに終了期限を設定できるようにしたい
 タスク一覧テーブルにdeadlineカラムを追加(済)


- [x] タスクに優先順位をつけたい
 タスク一覧テーブルにpriorityカラムを追加(済)


- [x] ステータス（未着手・着手・完了）を管理したい
 タスク一覧テーブルにstatusカラムを追加(済)


- [x] ステータスでタスクを絞り込みたい
 一覧画面プロトタイプ（済)
 タスク一覧テーブルにstatusカラムを追加(済)


- [x] タスク名・タスクの説明文でタスクを検索したい
 一覧画面プロトタイプ（済)


- [x] タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
 一覧画面プロトタイプ（済)


- [x] タスクにラベルなどをつけて分類したい
一覧画面プロトタイプ (済)


- [x] ユーザ登録し、自分が登録したタスクだけを見られるようにしたい
タスク一覧テーブルにユーザIDを入れた。


## プロトタイプ

プロトタイプと画面
![プロトタイプ](prototype.jpg "プロトタイプ")

## テーブル構成

### user table (ユーザテーブル)

| column name | カラム型 | プライマリキー | NULL | DEFALUT| 説明 |
|:-----------|:------------:|:------------:|:------------:|:------------:|:------------|
| user_id | INT | ○ | | |ユーザID|
| mail | VARCHAR(255) | | | |メールアドレス (uniq)|
| encrypted_password | VARCHAR(255)  | | | |暗号化されたパスワード|

index
- mail, encrypted_password
メール、パスワード認証用


### task table (タスク一覧のテーブル)

| column name | カラム型 | プライマリキー | NULL | DEFALUT | 説明 |
|:-----------|:------------:|:------------:|:------------:|:------------|:------------|
| task_id | INT | ○ | | | タスクID |
| task_name | VARCHAR(255) | | | | タスク名 |
| description | TEXT | | | | タスク詳細内容 |
| user_id | INT | | | | user_id |
| deadline | DATE | | ○ | NULL | 終了期限日 |
| priority | TINY INT |  | | | 優先度 (低：0, 中:1, 高:2) |
| status | TINY INT | | | 0 |ステータス (未着手:0, 着手:1, 完了: 2) | 

index
~~- user_id, task_name~~
~~タスク名で検索するため~~　(task_nameはlike検索なので、index貼っても意味ない？)

- user_id, priority
優先順位でソートするため

- user_id, deadline
終了期限でソートするため

- user_id, status
statusで検索するため

### master label table (ラベル管理テーブル)
| column name | カラム型 | プライマリキー | NULL | DEFALUT | 説明 |
|:-----------|:------------:|:------------:|:------------:|:------------|:------------|
| label_id | INT | ○ | | | master_label_id |
| label_name | varchar(100) | | | | ラベル名 (uniq) |

## task label manage table (タスク一覧で保持するラベルテーブル)

| column name | カラム型 | プライマリキー | NULL | DEFALUT | 説明 |
|:-----------|:------------:|:------------:|:------------:|:------------|:------------|
| task_label_id | INT | ○ | | | タスクで管理するラベルID |
| task_id | INT | | | | タスクID ※ multi(task_id, label_idでユニーク) |
| label_id | INT | | | | master label tableのlabel_id |

index
- task_id
一覧表示画面でtaskテーブルと結合するため

- task_id, label_id
一覧表示画面でラベル検索するため
