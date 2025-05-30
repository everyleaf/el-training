# el-training

## このカリキュラムについて

この文書は、万葉で必須とされるRuby on Railsとその周辺技術の基礎を習得するための新入社員教育用カリキュラムです。
新入社員の能力によらず、必ず一通りのステップを実施していただきます。
研修期間は特に定めておりません。
すべてのステップを完了した時点で研修修了となります。

本カリキュラムでは、以下の登場人物を想定しています。

- 新入社員 : 本カリキュラムの受講者です。
- サポーター : 新入社員の教育・指導・助言を行います。また、新入社員と相談して仕様を一緒に決めたりする役割も担います。

指導について、サポーターがどの程度関与するかどうかはサポーターの裁量に一任します。また、研修期間については、新入社員のスキルレベルや社内の案件状況を考慮して、サポーターの方であらかじめ目安を設定する予定です。

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

また、上記の要件を満たすにあたって、次のような管理機能がほしいと考えています。

- ユーザの管理機能

### サポートブラウザ

- サポートブラウザはmacOS/Chrome各最新版を想定しています

### アプリケーション（サーバ）の構成について

以下の言語・ミドルウェアを使って構築していただきたいです（いずれも最新の安定バージョン）。

- Ruby
- Ruby on Rails
- PostgreSQL

デプロイ先については以下を利用していただきたいです。

- Render

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
- 不明な点を適切なタイミングでチームメンバーや関係者に（今回はサポーターになります）口頭やチャットなどで質問ができること

## 推奨図書

研修カリキュラムを進めるにあたって、以下の書籍を推奨図書としてオススメします。

- [現場で使える Ruby on Rails 5速習実践ガイド](https://book.mynavi.jp/ec/products/detail/id=93905)

現場で使える Ruby on Rails 5速習実践ガイドでは、研修カリキュラムと同様にタスク管理システムを題材としています。
そのため、本研修を進める上で参考になる点が多数あるかと思います。

また、本研修ではカバーしきれなかった内容や、チーム開発の進め方についても解説されています。ぜひ参考にしてみてください。

## 技術情報を調べるための基本的なサイト

初めて使うメソッドなどについては、必ず下記のサイトで調べて進めるようにしましょう。

- [オブジェクト指向スクリプト言語 Ruby リファレンスマニュアル](https://docs.ruby-lang.org/ja/latest/doc/index.html)
- [Ruby on Rails API(リファレンス)](https://api.rubyonrails.org/)
- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
  - [(日本語版)](https://railsguides.jp/)

## 開発に役立つトピック集

特定の課題ステップには含められませんでしたが、活用してほしいトピックについて topics.md にまとめています。カリキュラムを実施する上で、必要に応じて参照して活用してください。

## 課題ステップ

### ステップ1: Railsの開発環境を構築しよう

#### 1-1: Rubyのインストール

- [rbenv](https://github.com/rbenv/rbenv)を利用して最新バージョンのRubyをインストールしてください
- `ruby -v` コマンドでRubyのバージョンが表示されることを確認してください

#### 1-2: Railsのインストール

- GemコマンドでRailsをインストールしましょう
- 最新バージョンのRailsをインストールしてください
- `rails -v` コマンドでRailsのバージョンが表示されることを確認してください

#### 1-3: データベース（PostgreSQL）のインストール

- 手元のOSでPostgreSQLをインストールしましょう
  - macOSの場合は `brew` などでインストールしてください

### ステップ2: GitHubにリポジトリを作成しよう

- 手元にGitをインストールしましょう
  - macOSの場合は `brew` などでインストールしてください
  - `gitconfig` でユーザ名、メールアドレスを登録しましょう
- アプリ名（=リポジトリ名）を考えましょう
- リポジトリを作成しましょう
  - アカウントがない場合は取得しましょう
  - その上で空のリポジトリを作成しましょう
- mac を使用している人は、間違ってGitに入れてしまわないように以下の設定を追加しておきましょう
  - ~/.config/git/ignore というテキストファイルを作り、以下を書き込みましょう
  - ```
    .DS_Store
    ```

### ステップ3: Railsプロジェクトを作成しよう

#### main ブランチに最初のコミットを積む

- `rails new` コマンドでアプリケーションに必要なディレクトリやファイルを作成しましょう
  - `rails new --help` でオプションを確認し、適切なオプションで作成しましょう
  - [Tailwind CSS](https://tailwindcss.com/) の導入を必須とします
  - DBは PostgreSQL を推奨としますが、サポーターと相談の上、他のDBを使うことも可能です
  - 以下のおすすめのオプションを参考にしてください
    - いろいろな機能を追加したい人向け：
      - `--css=tailwind --database=postgresql --skip-action-mailbox`
    - カリキュラムのことだけをすすめたい人向け：
      - `--css=tailwind --database=postgresql --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage --skip-action-cable --skip-jbuilder`
- `rails db:create` で、ローカル環境にデータベースを作り、`rails db:migrate` で `db/schema.rb` が生成されたことを確認しましょう
- バージョンを明示するため、利用するRubyのバージョンを `Gemfile` に記載しましょう
  - 例) `ruby "3.4.1"`
- アプリケーションディレクトリで `git status` を打ってみましょう
  - ローカルにリポジトリが作成されているのを確認できます
- `git add .` で作成したファイルをgitのstageに追加しましょう
- `git commit -m "initial commit"` などとして変更をコミットしましょう
- `git remote add origin https://github.com/{GitHubアカウント名}/{リポジトリ名}.git` として、ステップ2で作成したリモートリポジトリをローカルのgitに`origin`という名前で登録しましょう
- `git push origin main` でGitHubにpushしましょう
- GitHubへ見に行って、ファイルが登録されていることを確認しましょう

#### ブランチを切り README と docs を整える

- main からブランチを切りましょう
  - ※ 以下、各ステップでも任意の区切りでブランチを切って作業を進め、PR (Pull Request) を出す形で研修を行なっていきます
- ルートディレクトリにある README.md の内容を自分のアプリの内容に書き換えましょう
- 研修中に参照しやすいように、ルートディレクトリに `docs` というディレクトリを作り、この文書ファイル（el-training.md）をコピーして配置しましょう
- これらの変更をブランチに入れ、GitHub へ push し、PR を作成してレビューしてもらいましょう
  - 必要に応じて WIP（Work In Progress) で PR を出すようにしましょう。詳しくは[トピック集](https://github.com/everyleaf/el-training/blob/master/docs/topics.md#github-%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E3%83%88%E3%83%94%E3%83%83%E3%82%AF)を参照してください
  - コメントが付いたらその対応を行ってください。2人から approve されたら main ブランチにマージしましょう

#### Depandabot の通知について

GitHubが自動的に gem などのバージョンアップ等の PR を作ってくれる `dependabot` の機能については、トレイニーが自分で適切に判断しながらレビューをしてもらったり、PRを並列的に処理したりすることが難しいので、研修中は[オフにする](https://docs.github.com/ja/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates#disabling-dependabot-version-updates)ことも検討しましょう（研修を行う組織ごとのポリシーに応じて進めてください）。ファイル操作が必要になるため、新しく PR を作成して対応しましょう。

### ステップ4: 作りたいアプリケーションのイメージを考えよう

- 設計を進める前に、どのようなアプリになるか完成イメージ（画面設計）をサポーターと一緒に考えてみましょう
  - 図形描画ツール（[draw.io](https://drawio-app.com/)、[figma](https://www.figma.com/ja/) など) やペーパープロトタイピングを用いてプロトタイプを作成しましょう
  - また、このアプリがどのような形で利用されるか（インターネットに公開するのか、社内向けか、etc…）についても（サポーターと一緒に）考えてみましょう
- システムの要件を読んで、必要なデータ構造を考えてみましょう
  - どのようなテーブルが必要そうか・各テーブル名・カラム名・データ型・制約など、スキーマを作る際に必要な情報を考えてみましょう
- データ構造を考えたら、それをER図として書き起こしてみましょう
  - 完成したら、サポーターにレビューしてもらいましょう
  - サポーターにレビューしてもらった結果、問題なさそうであれば、リポジトリにER図を入れておきましょう（手書きの場合は撮影した画像を保存しましょう）
  - `README.md` にテーブルスキーマを記載してPRを作成し、レビューしてもらいましょう

※ 現時点で正解のER図を作成する必要はまだありません。現時点での想定として作ってみましょう（今後のステップで間違いと思ったら改修していくイメージです）

### ステップ5: データベースの接続設定（周辺設定）をしよう

- Bundlerをインストールしましょう
- `Gemfile` で `pg` （PostgreSQLのデータベースドライバ）をインストールしましょう
- `database.yml` の設定をしましょう
- `rails db:create` コマンドでデータベースの作成をしましょう
- `rails db` コマンドでデータベースへの接続確認をしましょう
- `README.md` にDBセットアップも含めた環境構築の手順をまとめましょう
- GitHub上でPRを作成してレビューしてもらいましょう

### ステップ6: タスクモデルを作成しよう

ここではモデルファイルを Rails の generator を使って自動作成しますが、その前に自動テストコードが自動生成されないようにします。（自動テストについてはステップ9で取り組みます。）config/application.rb に以下の設定を追加してください。

```ruby
   config.generators do |g|
     g.test_framework nil # TODO: RSpecを入れるまで生成されないようにしておく
   end
```

タスクを管理するためのCRUDを作成します。
まずは名前と詳細だけが登録できるシンプルな構成で作りましょう。

- `rails generate` コマンドでタスクのCRUDに必要なモデルクラスを作成しましょう
- マイグレーションを作成し、これを用いてテーブルを作成しましょう
  - マイグレーションは1つ前の状態に戻せることを担保できていることが大切です！ `redo` を流して確認する癖をつけましょう
  - DBの制約についても忘れず設定するようにしましょう
- `rails c` コマンドでモデル経由でデータベースに接続できることを確認しましょう
  - この時に試しにActiveRecordでレコードを作成してみましょう
- バリデーションを設定しましょう
  - どのカラムにどのバリデーションを追加したらよいか考えてみましょう
- GitHub上でPRを作成してレビューしてもらいましょう

### ステップ7: タスクを閲覧・登録・更新・削除できるようにしよう

ステップ7は7-1から7-4のサブステップに分かれています。
各ステップを順番に進めて、最終的にタスクの一覧画面、詳細画面、作成画面、編集画面、削除機能を作成することになります。

サブステップに分けているのは、全部を１つの巨大なPRにすると開発もレビューも大変になってしまうからで、実案件でもこのように、小さくわけて開発することが普通になっています。
今後のステップでも、PRが大きくなりそうな場合は2つ以上に分けてPRを出せないか検討しましょう。

なお、画面(ビュー)を作る際には適宜CSS(Tailwind CSS の class)を整えながら進めましょう。

#### ステップ7-1: タスクの一覧画面、詳細画面を作成しましょう

- ステップ6で作成したタスクを、一覧画面、詳細画面で表示できるようにしましょう
- `rails generate` コマンドでコントローラとビューを作成しましょう
  - どのテンプレートエンジンを採用するかはサポーターと相談して決めましょう
- コントローラとビューに必要な実装を追加しましょう
- `routes.rb` を編集して、 `http://localhost:3000/` でタスクの一覧画面が表示されるようにしましょう
- 一覧画面にアクセスする際、HTTPでどのようなやり取りが行われているかを調べ、サポーターに説明してみましょう

#### ステップ7-2: タスクの作成画面、編集画面を作成しましょう

- 画面上からタスクの作成や編集ができるようにしましょう
- 作成、更新後はそれぞれflashメッセージを画面に表示させましょう
  - バリデーションエラーが発生した場合は、エラーメッセージを画面に表示させましょう
- GitHub上でPRを作成してレビューしてもらいましょう

#### ステップ7-3: タスクを削除できるようにしましょう

- 作成したタスクを削除できるようにしましょう
- 削除後はflashメッセージを画面に表示させましょう
- GitHub上でPRを作成してレビューしてもらいましょう

##### 注意点
Rails7以降、削除については次の2点が従来と書き方が変わっています。

1. 削除後のリダイレクト時に、redirect_to の引数に status: :see_other を指定する必要がある
    - ※see_otherをつけないと、削除の処理の一環としてリダイレクトしている意味になり、リダイレクト先に DELETEメソッドで飛んでしまいます。
1. 削除に限りませんが、画面でリンクなどをクリックしたときに確認ダイアログを簡単に出す仕組みをRailsが提供しており、この仕組みの呼び方が変わっています。Rails7以降は、次のように記述します。
    - >  link_to "削除", ..., data { turbo_confirm: "...削除してよろしいですか？" }
    - ※ 上記のように書くと data-turbo-confirm 属性がつきます

#### ステップ7-4: 追加したコードを振り返ってみよう

- ステップ7-1〜7-3で追加したコードについて、サポーターに説明してみましょう
  - クラス、メソッド、変数について
  - 処理の流れについて

### ステップ8: SQLに触れてみよう

- データベースを操作しましょう
  - `rails db` コマンドでデータベースに接続しましょう
  - SQLでタスクの閲覧、作成、更新、削除をしましょう
- タスクの一覧画面にアクセスして、SQLのログが流れていることを確認しましょう
  - どのようなSQLが実行されているか、サポーターに説明してみましょう
- ActiveRecordのメソッドでどういうSQLが実行されるか確認してみましょう
  - `rails c` で `find` や `where` などを実行してみましょう
- 「SQLインジェクション」と「RailsでSQLインジェクションを起こさないための書き方」についてサポーターに説明してみましょう

### ステップ9: テストを書こう

- [rspec](https://github.com/rspec/rspec-rails) を導入しましょう
- ステップ6で config/application.rb に加えた変更を元に戻しましょう（test_framework の設定を消す）
- specを書くための準備をしましょう
  - `spec/spec_helper.rb` 、 `spec/rails_helper.rb` を用意しましょう
- model specをバリデーションに対して書いてみましょう
  - 実際はそれほどバリデーションのテストは書きませんが、model specへの理解を深めるためにやってみましょう
- system specをタスク機能に対して書いてみましょう
- RSpecの結果をSlackへ通知するようにGitHub Actionsに設定しましょう
  - サポーターが実施する形でも構いません
  - 設定の参考: https://github.com/everyleaf/el-training/tree/master/github_actions/.github/workflows/test.yml
- 参考書籍：https://leanpub.com/everydayrailsrspec-jp

### ステップ10: アプリの日本語部分を共通化しよう

- Railsのi18nの仕組みを利用して、モデル名・属性名やバリデーションエラーメッセージを日本語で表示できるようにしましょう
  - その際、[rails-i18が提供するロケールファイル](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/ja.yml) と独自に追加したモデルへのロケールファイルはわけて管理するようにしましょう

### ステップ11: Railsのタイムゾーンを設定しよう

- Railsのタイムゾーンを日本（東京）に設定しましょう

### ステップ12: デプロイをしよう

- mainブランチにシンプルなタスク管理システムができたので、デプロイしてみましょう。
- [Render](https://render.com/)にデプロイを実施してみましょう
  - アカウントがなければ登録しましょう
  - 登録するときのメールアドレスは会社・個人どちらでも構いません
  - デプロイ方法は公式ドキュメントの『[Getting Started with Ruby on Rails on Render](https://render.com/docs/deploy-rails)』を参考にすると良いでしょう
    - デプロイ方法は『[Use render.yaml to Deploy](https://render.com/docs/deploy-rails#use-renderyaml-to-deploy)』と『[Deploy Manually](https://render.com/docs/deploy-rails#deploy-manually)』の2つがあります
    - 無料プランだと『[Deploy Manually](https://render.com/docs/deploy-rails#deploy-manually)』しか利用できませんので、こちらを参考にしましょう
- デプロイされたRender上のアプリを触ってみましょう
  - Renderのアプリケーションはインターネットでどこでも参照できるので、公開してはまずい情報は載せないようにしましょう
    - Basic認証をこの時点でいれてもいいかもしれません
  - RenderはGitHubリポジトリに接続されるので、今後はmainブランチにPRがマージされたときに自動でデプロイされます
- RenderのアプリケーションのURLなどの情報を `README.md` に記載しましょう
  - その際に、このアプリで使っているフレームワークのバージョン情報なども記載しておくとなおよいです
- RenderのPostgreSQLは無料プランだと30日間しか利用できません。期限に注意して進めましょう

### ステップ13: インライン編集を追加しよう
- 一覧画面でタスクごとに編集ボタン等を設け、それを押すと一覧の該当行が編集可能になり、その場で更新ボタンをおせば、更新ができて一覧にも反映されるようにしてみましょう
- 7-2で作った編集機能（アクション、画面）はそのまま維持して、それとは別に [Turbo Frames](https://turbo.hotwired.dev/handbook/frames) （[日本語版](https://everyleaf.github.io/hotwire_ja/turbo/handbook/frames/)） を用いて、インライン用の編集・更新を作ってみましょう
- 最終的に、重複するビューをできるだけパーシャルにまとめるようにしましょう
- 注意：Turbo Frames を使って`<table>`の一部（`<tr>`以下など）を更新することはできません。なぜなら、`<turbo-frame>`タグが`<table>`と`<tr>`の間などに入るとテーブルとしてうまく認識されないからです。そのため、このステップに取り組む際には、もともと画面で`<table>`タグをつかっていた場合には、タグ組みの見直しが必要になるかもしれません。
- ヒント: このステップの前までで、登録画面・編集画面は共通化しているかもしれませんが、今回足すインライン編集も共通化しなければいけないという前提はありません。まずは新しく足すには何が必要かを考えて書いてみて、結果的に共通化できればするというスタンスで進めるとよいでしょう。

### ステップ14: 終了期限を追加しよう

- タスクに対して、終了期限を登録できるようにしてみましょう
- 一覧画面で、終了期限でソートできるようにしましょう
- あわせて、作成日時でもソートできるようにしてみましょう
- specを拡充しましょう
- PRしてレビューをしてもらったら、リリースしてみましょう

### ステップ15: ステータスを追加して、検索できるようにしよう

※ この研修では練習のため Ransack を使用せず、Form オブジェクトをスクラッチから作ることを推奨します。ただし、Form Object にはじめて取り組む方は、[Form Object にはじめて取り組む方向けの進め方アドバイス](#form-object-にはじめて取り組む方向けの進め方アドバイス)を参考に進めてください。

- ステータス（未着手・着手中・完了）を追加してみましょう
  - ActiveRecordの[enum](https://api.rubyonrails.org/classes/ActiveRecord/Enum.html)を利用してステータスを表現・管理してみましょう
- 一覧画面でタスク名とステータスで検索ができるようにしましょう
  - 検索機能はFormオブジェクトを導入して実装してみましょう
- 絞り込んだ際、ログを見て発行されるSQLの変化を確認してみましょう
  - 以降のステップでも必要に応じて確認する癖をつけましょう
- 検索インデックスを貼りましょう
  - ある程度まとまったテストデータを用意して log/development.log を見ながら動作確認を行い、インデックスの追加により速度が改善されることを確認しましょう
  - インデックスは、検索条件（WHERE句）や結合（JOIN）、並び替え（ORDER BY）で頻繁に使われるカラムに貼ると、検索速度が大幅に向上しますが、更新が多いカラムや低選択性（値の種類が少ない）なカラムには向いていません。そのため、研修アプリに登場する中で、比較的インデックスを貼るのに適していると思われる終了期限を題材に練習をします
  - 【オプション】PostgreSQLの explain などを使用して、データベース側でのインデックス使用状況なども見てみましょう
- 検索に対してmodel specを追加してみましょう（system specも拡充しておきましょう）
- 【オプション】検索条件とソート条件のすべての組み合わせを表にまとめましょう
  - アプリ内の複雑な挙動を把握することが目的です
  - 以下はシンプルな事例の表です。まとめる際の参考にしてください
  - 事例：赤と白の旗があり、それぞれを1本ずつ上げ下げする

|     | 旗を上げる      | 旗を下げる      |
|-----|------------|------------|
| 赤の旗 | 赤の旗が上がっている | 赤の旗が下がっている |
| 白の旗 | 白の旗が上がっている | 白の旗が下がっている |

#### Form Object にはじめて取り組む方向けの進め方アドバイス

Rails における Form Object とは、画面上にフォーム（inputフィールドなどの集合）として現れるようなデータのうち、モデルにうまく対応しないデータのクラスを作ってフォームと連動させるやり方、およびその作られたクラスのことを言います。Form Objectがあるとなぜ便利なのかを体験するために、 **最初は、検索条件やソートなどの条件を、独自にパラメータでアクションに送るというやり方で実装してみましょう。** このように実装すると、アクション側で個別のパラメータの値をみてモデルを扱うことになり、コードが散らかり、整理しづらいと感じると思います。その後でForm Object パターンを使う形にリファクタリング（コード改善）することで、「Form Object を使うとパラメータによる処理の違いをすっきり整理して書ける」というメリットを理解しやすくなると思います。
 
### ステップ16: 優先順位を設定しよう

- タスクに対して、優先順位（高中低）を登録できるようにしましょう
- 優先順位でソートできるようにしましょう
- system specを拡充しましょう
- PRしてレビューをしてもらったら、リリースしてみましょう（以降続けてください）

### ステップ17: ページネーションを追加しよう

- [Pagy](https://github.com/ddnexus/pagy)というGemを使って一覧画面にページネーションを追加してみましょう

### ステップ18: ユーザモデルを作成しよう

- ユーザモデルを作成してみましょう
- 最初のユーザをseedで作成してみましょう
- seedで作った最初のユーザとタスクが紐づくようにしましょう
  - 関連に対してインデックスを貼りましょう
  - ※ Renderにデプロイした際に、すでに登録されているタスクとユーザが紐づいているようにしてください（データメンテナンス）

### ステップ19: ログイン/ログアウト機能を実装しよう

- 追加のGemを使わず、自分で実装してみましょう
  - DeviseなどのGemを使わないことで、HTTPのCookieやRailsにおけるSessionなどの仕組みについて理解を深めることが目的です
  - また、一般的な認証についての理解を深めることも目的にしています（パスワードの取り扱いについてなど）
- ログイン画面を実装しましょう
- ログインしていない場合は、タスク管理のページに遷移できないようにしましょう
- タスクを作成したときに、タスクをログイン中のユーザに紐付けるようにしましょう
- 自分が作成したタスクだけを表示するようにしましょう
- ログアウト機能を実装しましょう

### ステップ20: ユーザの管理画面を実装しよう

- 画面上に管理メニューを追加しましょう
- 管理画面にはかならず `/admin` というURLを先頭につけるようにしましょう
  - `routes.rb` に追加する前に、あらかじめURLやルーティング名（ `*_path` となる名前）を想定して設計してみましょう
- ユーザ一覧・作成・更新・削除を実装しましょう
- ユーザを削除したら、そのユーザが抱えているタスクを削除するようにしてみましょう
- ユーザの一覧画面で、ユーザが持っているタスクの数を表示するようにしてみましょう
  - N+1問題を回避するための仕組みを取り入れましょう
- ユーザが作成したタスクの一覧が見られるようにしてみましょう

### ステップ21: ユーザにロールを追加しよう

- ユーザに管理ユーザと一般ユーザを区別するようにしてみましょう
- 管理ユーザだけがユーザ管理画面にアクセスできるようにしてみましょう
  - 一般ユーザが管理画面にアクセスした場合、専用の例外を出してみましょう
  - 例外を補足して、適切にエラーページを表示しましょう（ステップ23で実施しても構いません）
- ユーザ管理画面でロールを選択できるようにしましょう
- 管理ユーザが1人もいなくならないように削除の制御をしましょう
  - モデルのコールバックを利用してみましょう
- ※ Gemの使用・不使用は自由です

### ステップ22: タスクにラベルをつけられるようにしよう

- タスクに複数のラベルをつけられるようにしてみましょう
- つけたラベルで検索できるようにしてみましょう

### ステップ23: エラーページを適切に設定しよう

- Railsが用意しているデフォルトのエラーページを自分が作った画面にしてみましょう
- 状況に応じて、適切にエラーページを設定しましょう
  - ステータスコードの404ページと500ページの2種類の設定は少なくとも必須とします

## あとがき

お疲れさまでした。
あなたは教育カリキュラムを一通り完遂しました!!

このカリキュラムでは触れきれませんでしたが、今後は以下のトピックなどが必要になると思うので、学習を進めていくとよいと思います（案件を通じて学ぶことも多いと思います）。

- Webアプリケーションの基本的な理解を深める
  - HTTPとHTTPSに関する理解
- Railsのもう少し進んだ使い方を習得する
  - STI
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
  - PostgreSQLに関する設定への理解
- リリースに関するツールの理解
  - Capistrano
  - Ansible
