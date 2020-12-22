# JobSanとは
タスクを管理してくれるすごいやつ

# 環境構築

1. docker build
1. db migration
1. webpack compile(暫定)

## 1. コマンド実行
```
$ pwd
> ${リポジトリがある場所}/training/job_san
$ ls
> ... Dockerfile, docker-compose.yml
$ docker-compose up 
> webとdbとselenium_chromeが立ち上がったことを確認してください。
````

## 2. マイグレーション
   
`docker-compose up` が終わったらブラウザから `http://localhost:3000` へアクセスして下さい。

画面上にマイグレーション用のボタンが出力されているのでクリックしてください。

<img width="400" alt="docker-setup" src="docs/readme_images/docker_setup.png">

テスト実行用に以下も実行してください。
```
$ docker-compose run web bundle exec rails db:create
> Created database 'job_san_test'
```

## 3. webpack compile（暫定対応）

以下のエラー画面が表示された際、この項目を行ってください。

<img width="400" alt="docker-setup" src="docs/readme_images/webpacker_install.png">

webpackerのインストールが正しく行えていないです。

`rails new`のやり方がよくなかったっぽいです。余裕があったら直します。

以下のコマンドを実行してください。
```
$ docker-compose run web bundle exec rails webpacker:install
> Webpacker successfully installed
```

## 4. HELLO WORLD !
```
$ docker-compose up
> web_1              | * Listening on http://0.0.0.0:3000

ブラウザにアクセスしてください。
```

# 確認方法

## 動作確認
`docker-compouse up` してサーバを立ち上げてから`http://localhost:3000` へアクセスして下さい。

## テスト実行
1. `docker-compouse up` してサーバを立ち上げてから
1. `docker exec -it ${コンテナID} bash`でサーバに入って `bundle exec rspec`

## 注意事項

### 1. railsによるdbのマイグレーション関連
`ex: rake db:migrate:redo`

mysql側のバグ？で `utf8mb4のエスケープ文字を扱うことができません`。

railsで生成されたschemaファイルから`_utf8mb4\\'カラム名'\\`のエスケープしている部分を削除してください。（`git diff`で確認できます。）

参考: https://bugs.mysql.com/bug.php?id=100607
