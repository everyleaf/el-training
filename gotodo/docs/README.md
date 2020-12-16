# 概要
## 場所も登録できるタスク管理アプリ

## 特徴
近くを通りがかったらやる系のタスクを管理できる  
e.g. 雑誌で見かけたカフェに行く  
e.g. 期間限定イベントに行く


# TABLE SCHEMA

## タスクテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | id | SERIAL | PK |
| タスク名 | task_name | VARCHAR(255) | NN |
| 説明 | detail | TEXT | |
| 位置情報 | location| GEOMETRY | |
| 優先度番号 | priority_no | INT | FK(優先度テーブル.優先度番号) |
| ステータス番号 | status_no | INT | FK(ステータステーブル.ステータス番号) |
| ユーザID | user_id | INT | FK(ユーザテーブル.ID) |
| 終了期限 | end_date | DATETIME | |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## 優先度テーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | id | SERIAL | PK |
| 優先度番号 | priority_no | INT | NN |
| 優先度 | priority | VARCHAR(255) | NN |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## ステータステーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | SERIAL | PK |
| ステータス番号 | status_no | INT | NN |
| ステータス | VARCHAR(255) | NN |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## ラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | SERIAL | PK |
| ラベル | label_name | VARCHAR(255) | NN |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## タスクラベルテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | SERIAL | PK |
| タスクID | INT | FK(タスクテーブル.ID) |
| ラベルID | INT | FK(ラベルテーブル.ID) |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## ユーザテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | SERIAL | PK |
| ユーザ名 | user_name | VARCHAR(255) | NN |
| パスワード | password | VARCHAR(255) | NN |
| ロール番号 | role_no | INT | FK(ロールテーブル.ロール番号) |
| 画像URL | img_path | TEXT |  |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |

## ロールテーブル
| カラム名(論理) | カラム名(物理) | 型 | 制約 |
| --- | --- | --- | --- |
| ID | SERIAL | PK |
| ロール番号 | role_no | INT | NN |
| ロール名 | role_name | VARCHAR(255) | NN |
| 作成日 | created_at | TIMESTAMP | |
| 更新日 | created_at | TIMESTAMP | |
