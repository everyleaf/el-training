# 概要
## 場所も登録できるタスク管理アプリ

## 特徴
近くを通りがかったらやる系のタスクを管理できる  
e.g. 雑誌で見かけたカフェに行く  
e.g. 期間限定イベントに行く


# TABLE SCHEMA

## タスクテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| タスク名 | task_name | VARCHAR(255) | NN | t.string |
| 説明 | detail | TEXT | | t.text |
| 住所 | location| TEXT | | t.text
| 緯度 | lat | DOUBLE | | t.decimal |
| 経度 | lng | DOUBLE | | t.decimal |
| 優先度番号 | priority_no | INT | FK(優先度テーブル.優先度番号) | t.integer |
| ステータス番号 | status_no | INT | FK(ステータステーブル.ステータス番号) | t.integer |
| ユーザID | user_id | INT | FK(ユーザテーブル.ID) | t.integer |
| 終了期限 | end_date | DATETIME | | t.datetime |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## 優先度テーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| 優先度番号 | priority_no | INT | NN | t.integer |
| 優先度 | priority | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## ステータステーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ステータス番号 | status_no | INT | NN | t.integer |
| ステータス | status | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## ラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ラベル | label_name | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## タスクラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| タスクID | task_id | INT | FK(タスクテーブル.ID) | t.integer |
| ラベルID | label_id | INT | FK(ラベルテーブル.ID) | t.integer |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## ユーザテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ユーザ名 | user_name | VARCHAR(255) | NN | t.string |
| パスワード | password | VARCHAR(255) | NN | t.string |
| ロール番号 | role_no | INT | FK(ロールテーブル.ロール番号) | t.integer |
| 画像URL | img_path | TEXT | | t.text |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |

## ロールテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 | Rails |
| --- | --- | --- | --- | --- |
| ID | id | SERIAL | PK | 自動追加 |
| ロール番号 | role_no | INT | NN | t.integer |
| ロール名 | role_name | VARCHAR(255) | NN | t.string |
| 作成日 | created_at | TIMESTAMP | | t.timestamps |
| 更新日 | created_at | TIMESTAMP | | t.timestamps |
