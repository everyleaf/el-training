# el-training

万葉で必須とされるRuby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。

## ドキュメントの構成

- [docs/el-training.md](/docs/el-training.md)
  - 新入社員教育用カリキュラムのドキュメントです
- [docs/topics.md](/docs/topics.md)
  - カリキュラムに具体的には含まれていませんが、知ってほしいトピックをまとめたドキュメントです
- [docs/optional_issues.md](/docs//optional_issues.md)
  - オプション課題をまとめたドキュメントです

## 環境構築
### DB設定
`> $ rails new`
をするとデフォルトでsqlite3の使用を前提とした`database.yml`が作成されます。  
このタスク管理アプリではDBにPostgreSQLを使用します。  

1. PostgreSQLをインストール  
```
> $ brew install postgresql
```

2. PostgreSQLのインストールを確認
```
> $ postgres --version
> postgres (PostgreSQL) XX.X
```
3. PATHの確認
```
> $ which postgres #デフォルトのpostgresのパス
> user/local/bin/postgres
```

4. PGDATAのパスを登録  

`~/.bash_plofile`
```
# PostgreSQL 追加
export PGDATA=user/local/bin/postgres
```
設定を保存
```
> $ source ~/.bash_profile
```
5. ユーザ作成  
アプリ名をユーザとして定義  
```
> $ createuser task_app
```

6. DB作成
```
> $ createdb task_app_development -O task_app
> $ createdb task_app_test -O task_app
```
`createdb task_app_production` はHerokuのPostgreSQLを使用するので実行しない。  

7. DB起動
```
> $ brew services start postgresql
==> Successfully started ` postgresql` ...
...
```

8. DB権限付与  
ユーザの名前を確認(以下のMacUserの箇所に表示される)
```
> $ psql -c 'select * from pg_user' postgres
> usename  | usesysid | ... | usesuper | ...  
> ---------+----------+-...-+----------+-... 
> MacUser  |       10 | ... | t        | ...  
> task_app |    16384 | ... | t        | ...
```
```
> $ psql -U MacUser task_app_development
>
> task_app_development=# ALTER ROLE "task_app" WITH Superuser;
> ALTER ROLE
> task_app_development=# \du  # ユーザ一覧
>
>  Role name |   Attributes   | ...
> -----------+----------------+ ...
>  Macユーザ  | Superuser, ... | ...
>  MyApp     | Superuser      | ...
>
> task_app_development=# \q  # 操作終了
>
>brew services stop postgresql
```
## ライセンス

このカリキュラムは[クリエイティブ・コモンズ 表示 - 非営利 - 継承 4.0 国際 ライセンス](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.ja)の下に提供されています。

[![クリエイティブ・コモンズ・ライセンス](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.ja)

## Language Supports

- マンダリン（繁體字：zh_TW）
  - https://github.com/5xruby/5xtraining （@jodeci 様ありがとうございます！）
