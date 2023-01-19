# training

## このカリキュラムについて

この文書は、Fablicで必須とされるRuby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。
新入社員の能力によらず、必ず一通りのステップを実施していただきます。
研修期間は特に定めておりません。
すべてのステップを完了した時点で研修修了となります。

本カリキュラムでは、以下の登場人物を想定しています。

- 新入社員（メンティー） : 本カリキュラムの受講者です。
- メンター : 新入社員の教育・指導・助言を行います。また、新入社員と相談して仕様を一緒に決めたりする役割も担います。
  - レビューに関しては、メンター１人への負荷軽減・チームメンバーがメンティーのレベルを理解するよい機会になることから、チーム内で分担して行うことを推奨します。

指導について、メンターがどの程度関与するかどうかはメンターの裁量に一任します。また、研修期間については、新入社員のスキルレベルや社内の案件状況を考慮して、メンターの方であらかじめ目安を設定する予定です。

## ライセンス

このカリキュラムは[クリエイティブ・コモンズ 表示 - 非営利 - 継承 4.0 国際 ライセンス](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.ja)の下に提供されています。

[![クリエイティブ・コモンズ・ライセンス](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.ja)  

## 概要

### システムの要件

本カリキュラムでは、課題としてタスク管理システムを開発していただきます。
タスク管理システムでは、以下のことを行いたいと考えています。

- 自分のタスクを簡単に登録したい
- タスクに終了期限を設定できるようにしたい
- タスクに優先順位をつけたい
- ステータス（未着手・着手・完了）を管理したい
- ステータスでタスクを絞り込みたい
- タスク名・タスクの説明文でタスクを検索したい
- タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
- タスクにラベルなどをつけて分類したい
- ユーザ登録し、自分が登録したタスクだけを見られるようにしたい
- メンテナンスを実施できるようにしたい

また、上記の要件を満たすにあたって、次のような管理機能がほしいと考えています。

- ユーザの管理機能

**※ ただし、メンターの判断で特定機能の実装をスキップしてもらう場合があります。**
  **「★」のマークが付いているステップに関してはメンターの指示のもと、実装してください。**

**（メンターは、メンティーの開発経験・各ステップの実装の質を元にスキップするかの判断を行ってください）**


### サポートブラウザ

- サポートブラウザはmacOS/Chrome各最新版を想定しています

### アプリケーション（サーバ）の構成について

以下の言語・ミドルウェアを使って構築していただきたいです（いずれも最新の安定バージョン）。

- Ruby
- Ruby on Rails
- MySQL
- Docker Compose

※ 性能要求・セキュリティ要求は特に定めませんが、一般的な品質で作ってください。
  あまりにサイトのレスポンスが悪い場合は改善をしていただきます

## 本カリキュラムの最終目標

本カリキュラムの終了時点で、以下の項目を習得することを想定しています。

- Railsを利用した基本的なWebアプリケーションの実装ができるようになること
- Railsアプリケーションで一般的な環境を使ってアプリケーションを公開できること
- 公開されたRailsアプリケーションに対して、機能の追加やデータのメンテナンスができること
- GitHubでPRをしてマージする一連の流れを習得すること。また、それに必要なGitのコマンドを習得すること
  - 適切な粒度でコミットができること
  - 適切にPRの説明文が書けること
  - レビューに対する対応と修正が一通りできること
- 不明な点を適切なタイミングでチームメンバーや関係者に（今回はメンターになります）口頭やチャットなどで質問ができること

## 課題ステップ

### ステップ0: chrome-extensionをインストールしよう

実はこのtrainingは株式会社万葉が作ったものが元となっていて、間違えて本家のリポジトリに向かってPRを作るという事件が何回か起きてしまいました。
この悲劇を繰り返さないためにページが自動でリダイレクトされるchrome-extensionをインストールしましょう。

#### 0-1: chrome-extensionをcloneする

`git clone git@github.com:Fablic/fablic-chrome-extension.git`

#### 0-2: chrome-extensionをインストールする

chrome://extensions/ を開いて右上のDeveloper modeをオンにして、RKGithubSupportToolをドラッグ&ドロップでインストールしましょう。

#### 0-3: 株式会社万葉に感謝しつつトレーニングを始める

[本家のリポジトリ](https://github.com/everyleaf/el-training)

### ステップ1: 開発環境を構築しよう

#### 1-1. Dockerのインストール

- 公式サイトからDockerのアカウントを作ってログインし、DockerHubからダウンロードしてインストールしましょう
    - https://hub.docker.com/editions/community/docker-ce-desktop-mac
- `docker-compose -v` コマンドでバージョンが表示されることを確認してください
  - Mac M1チップの場合  
      ```sh
      docker-compose docker: 'compose' is not a docker command
      ```
      が出る可能性があります。  
      解決策：
      ```sh
      mkdir -p /usr/local/lib/docker
      ln -s /Applications/Docker.app/Contents/Resources/cli-plugins /usr/local/lib/docker/cli-plugins
      ```
      参考：https://github.com/docker/for-mac/issues/6569#issuecomment-1312244210


#### 1-2. Gitのインストール

- 手元にGitをインストールしましょう
  - macOSの場合は `brew` などでインストールしてください
    - macOSは初めからインストールされていますが、最新版をインストールすることをお薦めします
  - `gitconfig` でユーザ名、メールアドレスを登録しましょう

### ステップ2: リポジトリの初期設定をしよう

- ブランチを作成しましょう
  - masterブランチを元に自分のアカウント名と同じ名前で作成してください
    - `git checkout -b github_account_name origin/master`
  - 作成したらpushしましょう

### ステップ3: Railsプロジェクトを作成しよう

- 作業ディレクトリに移動します
    ```sh
    cd myapp
    ```
- 自分の名前を`myapp/.env`に追加します
    ```yml
    COMPOSE_PROJECT_NAME=〇〇-training # 〇〇に自分の名前を入力
    # ex) COMPOSE_PROJECT_NAME=Taro-training
    ```
- 下記コマンドでアプリケーションに最低限必要なディレクトリやファイルを作成しましょう
    ```sh
    docker-compose run api rails new . --force --database=mysql -G
    ```
    - Mac M1チップの場合  
      - dockerコマンド実行したときチップによるエラーが幾つかあります。
        ```sh
        no matching manifest for linux/arm64/v8 in the manifest list entries
        ```  
        こういうエラーが出る場合、
        `docker-compose.yml`の`api:`と`db:`配下に
        ```yml
        platform: linux/amd64
        ```
        を指定して再実行してください。
        参考：[M1 MacによるDocker開発環境構築エラー](https://qiita.com/a-kym/items/10ecb57e0387a673b3a2)
      - ```sh
        executor failed running [/bin/sh -c apt-get install -y google-chrome-stable]: exit code: 100
        ```  
        こういうエラの場合、Dockerfileを弄って
        ```yml
        ENV DOCKER_DEFAULT_PLATFORM=linux/amd64
        ```
        を指定してください。
        参考：[Unable to locate package google-chrome-stable](https://github.com/joyzoursky/docker-python-chromedriver/issues/30)
        `docker-compose.yml`の`chrome:`配下に
        ```yml
        platform: linux/amd64
        ```
        指定してもよい気がします。  
      ここで出なくても今後のStepでこれが出る可能性がありますので、出たら上記の解決策を試しましょう。

- `rails new` してできたプロジェクトのディレクトリ（アプリ名のディレクトリ）の直下に `docs` というディレクトリを作り、この文書ファイルをコミットしましょう
  - このアプリの仕様を管理下に置き、いつでも見られるようにするためです
- `config/database.yml`を以下のように書き換えて、アプリから接続できるようにしましょう
    ```yml
    default: &default
      adapter: mysql2
      encoding: utf8mb4
      charset: utf8mb4 # ここを追加
      collation: utf8mb4_general_ci # ここを追加
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      database: <%= ENV['DB_NAME'] %> # from docker-compose.yml 
      username: <%= ENV['DB_USER'] %> # from docker-compose.yml 
      password: <%= ENV['DB_PASSWORD'] %> # from docker-compose.yml 
      host: <%= ENV['DB_HOST'] %> # from docker-compose.yml 
    ```
    - 他の部分はそのままで大丈夫です
- 以下のコマンドでDockerをビルドしてアプリを立ち上げましょう
    ```sh
    docker-compose up --build
    ```
    - Mac M1チップの場合： 
      ```sh
      Webpacker::Manifest::MissingEntryError
      ``` 
      こういうエラーが出る場合、  
      `Gemfile`ファイル内のwebpackerを最新のものにする。
      ```yml
      gem 'webpacker', '~> 5.0'
      ```
      を指定して再実行してみてください。
      参考：[【Rails6】Webpacker::Manifest::MissingEntryErrorを解決する](https://qiita.com/ginger-yell/items/8584e9149496940ea144)
        
      ```sh
      Function not implemented - Failed to initialize inotify (Errno::ENOSYS)
      ``` 
      の場合：
      `config/environments/development.rb`を編集してください。
      ```
      - config.file_watcher = ActiveSupport::EventedFileUpdateChecker
      + config.file_watcher = ActiveSupport::FileUpdateChecker
      ```
    - `sassc 2.4.0`の場合`bundle install`ですごく時間かかる場合があります（1000s以上）基本的は待つと大丈夫です、気になったらこの記事を読んでください。
      - [Rails: Why is bundle install frozen up by sassc 2.4.0](https://stackoverflow.com/questions/62720043/rails-why-is-bundle-install-frozen-up-by-sassc-2-4-0)
    - 以下のように表示されれば正常にアプリが立ち上がっています
      ```sh
      api_1  | => Booting Puma
      api_1  | => Rails 6.0.0 application starting in development 
      api_1  | => Run `rails server --help` for more startup options
      api_1  | Puma starting in single mode...
      api_1  | * Version 3.12.1 (ruby 2.6.4-p104), codename: Llamas in Pajamas
      api_1  | * Min threads: 5, max threads: 5
      api_1  | * Environment: development
      api_1  | * Listening on tcp://0.0.0.0:3000
      api_1  | Use Ctrl-C to stop
      ```
    - `localhost:3001`にアクセスしてみましょう
- 作成したアプリをGitHub上に作成したブランチにpushしましょう
  - pushする前にgitignoreを設定したほうがおすすめ：[【Rails】.gitignoreの設定について](https://qiita.com/nozonozo/items/011308bf8f903977ac1a)

### ステップ4: Dockerに慣れましょう

開発中に使うDocker Composeのコマンドは以下の通りです。実際に実行してみて慣れていきましょう。

- アプリを起動する
    - `docker-compose up`
        - MySQLとRailsが起動し、ブラウザからアクセスできるようになります
        - SequelPro等を使ってDBに接続することも可能です。ポートやユーザー情報は`docker-compose.yml`を確認しましょう
    - `docker-compose up -d`
        - デーモンで動かす方法です。常に立ち上げた状態にしたければこちらを利用してください。
        - `docker-compose down`で停止します
- Railsのコマンドを実行する
    - `docker-compose exec api xxx`
        - `docker-compose exec`は立ち上がっているコンテナに命令を実行します
        - `api`は`docker-compose.yml`の`services`の名前を記載して、コンテナを指定します
        - `xxx`の部分には`rails c` や `rails db:migrate:status`、 `rails generate xxx` など自由にrailsのコマンドを指定して実行できます
    - 以後のドキュメントではコマンド実行に`docker-compose exec api`を省略しますので、適宜読み替えてください
- その他のTips
    - `docker-compose exec api /bin/bash`
        - dockerの中に入ります
    - `docker-compose exec api tail -f log/development.log`
        - dockerの中には入らずにlogをtailします
- Dockerでやっていることを理解しましょう
    - Dockerfile : Dockerを立ち上げて必要なファイルをコピーし、Railsをインストールしたりする処理を定義しています
    - docker-compose.yml : MySQLとRailsのアプリを連携して起動する処理を定義しています
        - このファイルに`rails db:create`などの一連の処理が書いてあるので、dockerを立ち上げるだけでRailsが起動してくれます
    - mysqlにはローカルから次のコマンドで接続できます `mysql -h 127.0.0.1 -u root -p -P 3316`
        - sequel proなどのツールも上記の設定で接続可能です
- 開発について
    - ローカルのファイルを変更したらDocker側のファイルも自動で変更されますので、自由なエディタで開発を進めましょう
    - vimとかRubyMineはdockerプラグインが提供されてます。テストの実行などをIDE上でやりたい場合は、必要なプラグインを入れておきましょう。

### ステップ5: 作りたいアプリケーションのイメージを考える

- 設計を進める前に、どのようなアプリになるか完成イメージを（メンターと一緒に）考えてみましょう。ペーパープロトタイピングによる画面設計などがおすすめです
- システムの要件を読んで、必要なデータ構造を考えてみましょう
  - どのようなモデル（テーブル）が必要そうか
  - テーブル内にどのような情報が必要そうか
- データ構造を考えたら、それをモデル図に手書きで書いてみましょう
  - 完成したら撮影して、リポジトリに入れましょう
  - `README.md` にテーブルスキーマを記載しましょう（モデル名・カラム名・データ型）

※ 現時点で正解のモデル図を作成する必要はまだありません。現時点での想定として作ってみましょう（今後のステップで間違いと思ったら改修していくイメージです）

### ステップ6: タスクモデルを作成しましょう

タスクを管理するためのCRUDを作成します。
まずは名前と詳細だけが登録できるシンプルな構成で作りましょう。

- `rails generate` コマンドでタスクのCRUDに必要なモデルクラスを作成しましょう
- マイグレーションを作成し、これを用いてテーブルを作成しましょう
  - マイグレーションは1つ前の状態に戻せることを担保できていることが大切です！ `redo` を流して確認する癖をつけましょう
- `rails c` コマンドでモデル経由でデータベースに接続できることを確認しましょう
  - この時に試しにActiveRecordでレコードを作成してみましょう
- GitHub上でPRを作成してレビューしてもらいましょう
  - コメントがついたらその対応を行ってください。LGTM（Looks Good To Me）が2つついたら元のブランチにマージしましょう

### ステップ7: タスクを登録・更新・削除できるようにしよう

- タスクの一覧画面、作成画面、詳細画面、編集画面を作成しましょう
  - `rails generate` コマンドでコントローラとビューを作成します
  - コントローラとビューに必要な実装を追加しましょう
  - 作成、更新、削除後はそれぞれflashメッセージを画面に表示させましょう
- `routes.rb` を編集して、 `http://localhost:3000/` でタスクの一覧画面が表示されるようにしましょう
- `Gemfile` で [RuboCop](https://github.com/rubocop/rubocop)（Rubyの静的コード解析ツール） か [fablicop](https://github.com/Fablic/fablicop)をインストールしましょう。設定やコマンド実行方法は各READMEから確認しましょう。
- GitHub上でPRを作成してレビューしてもらいましょう
  - 今後、PRが大きくなりそうだったらPRを2回以上に分けることを検討しましょう

### ステップ8: テスト(system spec)を書こう
- First make sure that these gems are exist in Gemfile
  ```
  group :test do
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'
  end
  ```
  **Note**: Remove the `webdrivers` gem from your Gemfile. If `webdrivers` is present, it will attempt to  find Chrome in your application’s container. 
  As Chrome isn’t installed  in the Dockerfile, the spec will fail.
  
- Before start testing we need to register a new driver with Capybara that is configured to use the Selenium container, add the below codes to 
  `spec/rails_helper.rb`
  ```
  Capybara.register_driver :remote_chrome do |app|
    hub_url = 'https://chrome:4444/wd/hub'
    chrome_capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions' => {
        'args' => %w[no-sandbox headless disable-gpu window-size=1680,1050],
      },
    )
    Capybara::Selenium::Driver.new(app, browser: :remote, url: hub_url, desired_capabilities: chrome_capabilities)
  end

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 3000
    Capybara.app_host = "https://#{Capybara.server_host}:#{Capybara.server_port}"
  end
  ```
- specを書くための準備をしましょう
  - `spec/spec_helper.rb` 、 `spec/rails_helper.rb` を用意しましょう
- ~~feature spec~~ system specをタスク機能に対して書きましょう
  - Rails 5.1 以降、新たにsystem testの機能を追加しました
    - [日本語](https://qiita.com/jnchito/items/c7e6e7abf83598a6516d), [英語](https://rossta.net/blog/why-rails-system-tests-matter.html)
  - dockerを利用して研修を行う場合、以下の設定が必要です。
    1. [Dockerfile](https://qiita.com/ngron/items/f61b8635b4d67f666d75#failed-to-read-the-sessionstorage-property-from-window-storage-is-disabled-inside-data-urls)
    2. [spec/rails_helper.rb](https://commis.hatenablog.com/entry/2018/11/16/171608)
    3. （Mac M1チップの方のみ）docker-composeファイルのchrome部分をこう書き換えてください。
        ```yml
        chrome:
          image: seleniarm/standalone-chromium
          ports:
            - 4444:4444
          environment:
            TZ: Asia/Tokyo
        ```  

  - feature specですと `database_cleaner` という gemは必要でしたが、 system specに変更することで `database_cleaner` の導入が要らなくなった
- Circle CIなどのCIツールを導入して、Slackに通知するようにしましょう
  - Fablic/training内でPRのやり取りをする場合、CIツールの導入は任意(optional)です。CircleCIのAdmin権限が無いので、`.circleci/config.yml`を設定しても実行できないです。
- 参考書籍：https://leanpub.com/everydayrailsrspec-jp

### ステップ9: アプリの各種設定を行いましょう

- 日本語部分を共通化
  - Railsのi18nの仕組みを利用して、日本語リソースの共通化をしましょう
  - ※i18n化を行うと後のステップでメッセージを出したりするのが楽になるなどのメリットがあります
- タイムゾーンの設定
  - Railsのタイムゾーンを日本（東京）に設定しましょう
- エラーページの設定
  - Railsが用意しているデフォルトのエラーページを自分が作った画面にしてみましょう
  - 状況に応じて、適切にエラーページを設定しましょう
  - ステータスコードの404ページと500ページの2種類の設定は少なくとも必須とします

### ステップ10: タスク一覧を作成日時の順番で並び替えましょう ★ スキップ可能

- 現在IDの順で並んでいますが、これを作成日時の降順で並び替えてみましょう
- 並び替えがうまく行っていることをsystem specで書いてみましょう

### ステップ11: バリデーションを設定してみよう

- バリデーションを設定しましょう
  - どのカラムにどのバリデーションを追加したらよいか考えてみましょう
  - 合わせてDBの制約も設定するマイグレーションを作成しましょう
  - マイグレーションファイルだけを作成するため、 `rails generate` コマンドで作成します
- 画面にバリデーションエラーのメッセージを表示するようにしましょう
- バリデーションに対してモデルのテストを書いてみましょう
- GitHub上でPRを作成してレビューしてもらいましょう

### ステップ12: 終了期限を追加しよう ★ スキップ可能

- タスクに対して、終了期限を登録できるようにしてみましょう
- 一覧画面で、終了期限でソートできるようにしましょう
- specを拡充しましょう
- PRしてレビューをしてもらったら、リリースしてみましょう

### ステップ13: ステータスを追加して、検索できるようにしよう

- ステータス（未着手・着手中・完了）を追加してみよう
  - 【オプション要件】初学者ではない場合はstateを管理するGemを導入しても構いません
- 一覧画面でタイトルとステータスで検索ができるようにしよう
  - 【オプション要件】初学者ではない場合はransackなどの検索の実装を便利にするGemを導入しても構いません
- 絞り込んだ際、ログを見て発行されるSQLの変化を確認してみましょう
  - 以降のステップでも必要に応じて確認する癖をつけましょう
- 検索インデックスを貼りましょう
- 検索に対してmodel specを追加してみよう（system specも拡充しておきましょう）

### ステップ14: ページネーションを追加しよう

- KaminariというGemを使って一覧画面にページネーションを追加してみましょう

### ステップ15: デザインを当てよう ★ スキップ可能

- Bootstrapを導入して、これまで作成したアプリにデザインを当てましょう
  - 【オプション要件】自分でCSSを書いてデザインする

### ステップ16: 複数人で利用できるようにしよう（ユーザの導入）

- ユーザモデルを作成してみましょう
- 最初のユーザをseedで作成してみましょう
- ユーザとタスクが紐づくようにしましょう
  - 関連に対してインデックスを貼りましょう
  - N+1問題を回避するための仕組みを取り入れましょう
    - N+1クエリを自動検出するbulletを導入してみましょう（[参考記事](https://fablic.qiita.com/craftcat/items/b181b67ddae0c7d0702a)）

### ステップ17: ログイン/ログアウト機能を実装しよう

- 追加のGemを使わず、自分で実装してみましょう
  - DeviseなどのGemを使わないことで、HTTPのCookieやRailsにおけるSessionなどの仕組みについて理解を深めることが目的です
  - また、一般的な認証についての理解を深めることも目的にしています（パスワードの取り扱いについてなど）
- ログイン画面を実装しましょう
- ログインしていない場合は、タスク管理のページに遷移できないようにしましょう
- 自分が作成したタスクだけを表示するようにしましょう
- ログアウト機能を実装しましょう

### ステップ18: ユーザの管理画面を実装しよう ★ スキップ可能

- 画面上に管理メニューを追加しましょう
- 管理画面にはかならず `/admin` というURLを先頭につけるようにしましょう
  - `routes.rb` に追加する前に、あらかじめURLやルーティング名（ `*_path` となる名前）を想定して設計してみましょう
- ユーザ一覧・作成・更新・削除を実装しましょう
- ユーザを削除したら、そのユーザが抱えているタスクを削除するようにしてみましょう
- ユーザの一覧画面で、ユーザが持っているタスクの数を表示するようにしてみましょう
- ユーザが作成したタスクの一覧が見られるようにしてみましょう

### ステップ19: ユーザにロールを追加しよう ★ スキップ可能

- ユーザに管理ユーザと一般ユーザを区別するようにしてみましょう
- 管理ユーザだけがユーザ管理画面にアクセスできるようにしてみましょう
- ユーザ管理画面でロールを選択できるようにしましょう
- 管理ユーザが1人もいなくならないように削除の制御をしましょう
- ※ Gemの使用・不使用は自由です

### ステップ20: タスクにラベルをつけられるようにしよう

- タスクに複数のラベルをつけられるようにしてみましょう
- つけたラベルで検索できるようにしてみましょう

### ステップ21: メンテナンス機能を作ろう

- メンテナンスを開始／終了するバッチを作ってみましょう
- メンテナンス中にアクセスしたユーザはメンテナンスページにリダイレクトさせましょう
- 追加のGemを使わず、自分で実装してみましょう

## あとがき

お疲れさまでした。
あなたは教育カリキュラムを一通り完遂しました!!

せっかく1つのアプリケーションを作り上げたので、是非makitani night(社内LT会)でアプリケーションについて発表してみましょう。
発表の良いきっかけにもなると思います。

このカリキュラムでは触れきれませんでしたが、今後は以下のトピックなどが必要になると思うので、学習を進めていくとよいと思います（案件を通じて学ぶことも多いと思います）。

- Webアプリケーションの基本的な理解を深める
  - HTTPとHTTPSに関する理解
- Railsのもう少し進んだ使い方を習得する
  - ロギング
  - 明示的なトランザクション
  - 非同期処理
  - アセットパイプライン（どちらかというとリリース系のトピック）
- JavaScriptやCSSなどのフロントエンドに関するより高度な理解
- データベースに対する理解を深める
  - SQL
  - よりパフォーマンスを重視したクエリの構築
  - インデックスの理解をより深める
- サーバ環境に関するより多くの理解
  - Linux OS
  - Webサーバ（Nginx）の設定
  - アプリケーションサーバ（Unicorn）の設定
  - MySQLに関する設定への理解
- リリースに関するツールの理解
  - Capistrano
  - Ansible

## （番外編）オプション要件

必須要件とは別に、タスク管理システムに関するオプション要件を以下に示します。
メンターと相談しつつ必要に応じて実施してみてください。

### オプション要件1:  終了間近や期限の過ぎたタスクがあった場合、アラートを出したい

- ログインした時点で、どこかに終了間近や期限の過ぎたタスクを表示してみましょう
- 既読などが分かるようになるとよりよい

### オプション要件2:  ユーザの間でタスクを共有できるようにしたい

- 複数人で同じタスクを参照・編集できるようにしたい
  - 例：メンターとメンティーでタスクを共有できること
- 作成者を表示する

### オプション要件3: グループを設定できるようにしたい

- オプション要件2の続き
- グループを設定できるようにして、グループ内だけでタスクを参照できるようにしたい

### オプション要件4: タスクに添付ファイルをつけられるようにしたい

- タスクに対して添付ファイルをつけられるようにしてみましょう
- Herokuの場合はS3バケットにアップロードした添付ファイルを管理するようにします
- 適切にGemを選別して利用してみましょう

### オプション要件5: ユーザにプロフィール画像を設定できるようにしてみましょう

- ユーザがプロフィール画像を設定できるようにしましょう
- アップロードした画像はアイコンとして使用するので、遅くならないようにサムネイル画像も作りたい
- 適切にGemやライブラリを選別しましょう

### オプション要件6: タスクカレンダーの機能がほしい

- 終了期限を可視化するために、カレンダーに終了期限別にタスクを表示するようにしてみましょう
- ライブラリの使用・不使用は自由です

### オプション要件7: タスクをドラッグ&ドロップで並べ替えられるようにしたい

- タスク一覧でタスクをドラッグ&ドロップして並べ替えできるようにしてみましょう

### オプション要件8: ラベルの使用頻度をグラフ化してみましょう

- 統計情報を可視化するために、グラフを導入してみましょう
- グラフの種類は見やすいものを提案してみましょう

### オプション要件9: 終了間近のタスクを作成ユーザ宛てにメール通知してみましょう

- 終了間近のタスクがある場合、バックグラウンドでメール通知してみましょう
- メール送信はクラウドサービスを利用します
  - HerokuならばSendGrid
  - AWSならばAmazon SESなど
- 1日1回のバッチで送信するようにしてみましょう
  - HerokuならばHeroku Scheduler（アドオン）
  - AWSだったらcronを設定してみる

### オプション要件10: AWS にインスタンスを作って環境構築する

- AWSに環境構築をしてデプロイしてみましょう
- ミドルウェアはNginx+Unicornを推奨構成とします
- EC2のインスタンス等はサーバ要件を参照してください

### オプション要件11: ラベルをつけるにあたりjavascriptを用いて非同期処理にて取得するようにしましょう

- ステップ20の続き
- タスク登録時のラベル初期表示時は、非表示(ラベルデータ未取得)にしてみましょう
- 変わりにラベル追加などのボタンを用意し、そのボタン押下にてラベルデータを取得し表示するようにしてみましょう
- テストも書きましょう
