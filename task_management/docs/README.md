# training
## テーブル構成
### user
| カラム名 | データ型| プライマリキー | 備考 |
|:-----------:|:------------:|:------------:|:------------:|
| id | INT | ○  | |
| name | VARCHAR | | |
| mail_address | VARCHAR | | |
| password_digest | VARCHAR | | |
| role | TINYINT | | 管理者ユーザ：0, 一般ユーザ：1 |
| create_at | DATETIME | | |
| update_at | DATETIME | | |

### task
| column name | データ型| プライマリキー | 備考 |
|:-----------:|:------------:|:------------:|:------------:|
| id | INT | ○ | |
| user_id | INT | | userテーブルのID |
| title | VARCHAR | | |
| description | TEXT | | |
| priority | TINYINT | | 低：0, 中:1, 高:2 |
| status | TINYINT | | 未着手:0, 着手:1, 完了: 2 |
| due | DATE | | |
| label_id | INT | | labelテーブルのID |
| create_at | DATETIME  | | |
| update_at | DATETIME | | |

### label
| column name | データ型| プライマリキー | 備考 |
|:-----------:|:------------:|:------------:|:------------:|
| id | INT | ○ | |
| name | VARCHAR | | |
| user_id | INT | | userテーブルのID |
| create_at | DATETIME  | | |
| update_at | DATETIME | | |
