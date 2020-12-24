# GoToDo!!!

## OVERVIEW
* 場所も登録できるタスク管理アプリ
* 近くを通りがかったらやる系のタスクを管理できる  
  e.g. 雑誌で見かけたカフェに行く  
  e.g. 期間限定イベントに行く


## REQUIREMENT
* Docker


## ENVIRONMENT
* Ruby
```
# ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]
```

* Ruby on Rails
```
# rails -v
Rails 6.1.0
```

* MySQL
```
# mysql --version
mysql  Ver 8.0.22 for Linux on x86_64 (MySQL Community Server - GPL)
```


## INSTALL
```
$ cd training/gotodo/
$ docker-compose build
$ docker-compose up -d
```


## TABLE SCHEMA

### タスクテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| タスク名 | task_name | VARCHAR(255) | NN | t.string |
| 説明 | detail | TEXT | | t.text |
| 住所 | location| TEXT | | t.text
| 緯度 | lat | DOUBLE | | t.decimal |
| 経度 | lng | DOUBLE | | t.decimal |
| ステータス | status | INT |  | t.integer (enum) |
| 優先度ID | priority_id | INT | FK(優先度テーブル.優先度ID) | t.references :priority, foreign_key: true |
| ユーザID | user_id | INT | FK(ユーザテーブル.ID) | t.references :user, foreign_key: true |
| 終了期限 | end_date | DATETIME | | t.datetime |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

### 優先度テーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| 優先度番号 | priority_no | INT | NN | t.integer |
| 優先度 | priority | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

### ラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ラベル | label_name | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

### タスクラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| タスクID | task_id | INT | FK(タスクテーブル.ID) | t.integer |
| ラベルID | label_id | INT | FK(ラベルテーブル.ID) | t.integer |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

### ユーザテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ユーザ名 | user_name | VARCHAR(255) | NN | t.string |
| パスワード | password | VARCHAR(255) | NN | t.string |
| ロールID | role_id | INT | FK(ロールテーブル.ロールID) | t.references :role, foreign_key: true |
| 画像URL | img_path | TEXT | | t.text |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

### ロールテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ロール番号 | role_no | INT | NN | t.integer |
| ロール名 | role_name | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |
