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


## STEP 5

### ステップ5: データベースの接続設定（周辺設定）をしましょう

- [X] まずGitで新たにトピックブランチを切りましょう
  - 以降、トピックブランチ上で作業をしてコミットをしていきます
  
- [X] Bundlerをインストールしましょう
-  [X]  `Gemfile` で `mysql2` （MySQLのデータベースドライバ）をインストールしましょう
-  [ ]  `database.yml` の設定をしましょう
-  [ ]  `rails db:create` コマンドでデータベースの作成をしましょう
-  [ ]  `rails db` コマンドでデータベースへの接続確認をしましょう
-  [ ] GitHub上でPRを作成してレビューしてもらいましょう
  - コメントがついたらその対応を行ってください。LGTM（Looks Good To Me）が2つついたらmasterブランチにマージしましょう

### Bundlerってなに？
https://qiita.com/oshou/items/6283c2315dc7dd244aef

npmとかyurnみたいにgemのライブラリのバージョン管理してくれるもの
既にインストール済み

```
$ bundler -v 
Bundler version 1.16.6
```

### `Gemfile` で `mysql2` （MySQLのデータベースドライバ）をインストールしましょうってなに？
bundle使ってGemfileにリスト化したgemを一括でインストールできる

mysql2のバージョン確認
```
 gem list mysql2 --remote
 
 mysql2 (0.5.2 ruby x64-mingw32 x86-mingw32 x86-mswin32-60)
```

:require => false
https://teratail.com/questions/88151
```
Bundler.requireを使うと、個別にrequire 'hoge'を書かなくても、Gemfileに書かれたgemを一括でrequireすることができます。このとき、:require => falseが指定されたgemは対象から除外されます。
```

Gemfileの修正箇所

- Gemfileからsqlite3の記述を削除、代わりにmysql2の記述を追記

一括インストール
```
$ bundle install --path vendor/bundle
```

Railsアプリにインストールされているgem一覧を見る方法
```
$ bundle list 
```

### database.ymlの書き換え
参考
https://qiita.com/shi-ma-da/items/caac6a0b40bbaddd9a6f
- adapter: sqlite -> mysql2へ変更

### rails db:createcommandでデータベース作成
```
$ rails db:create
Created database 'hajimeaiizuka_task_manager_develop'
Created database 'hajimeaiizuka_task_manager_test'
```

### rails dbコマンドで接続確認
```
$ rails db
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 33
Server version: 5.6.41 Homebrew

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+------------------------------------+
| Database                           |
+------------------------------------+
| information_schema                 |
| fril                               |
| fril_test                          |
| hajimeaiizuka_task_manager_develop |
| hajimeaiizuka_task_manager_test    |
| mysql                              |
| performance_schema                 |
| test                               |
+------------------------------------+
8 rows in set (0.00 sec)
```

