## 本研修カリキュラムのおすすめRuboCop設定の利用方法
[RuboCop](https://github.com/rubocop/rubocop)を導入して、
以下の3つのファイルを、アプリケーションのルートディレクトリ内にコピーしてください。

- .rubocop.yml
- .elcop.yml
- .elcop-rspec.yml

ご自分で設定をカスタマイズされる場合は、.rubocop.yml に記述します。
.elcop.yml と .elcop-rspec.yml は、本研修カリキュラムの一部として更新される場合があります。
必要に応じて新しいバージョンに置き換えてご利用ください。

## RubocopのSuggestionについて
研修を進めていくうちに`capybara`などのgemをインストールすることがあると思います。
それぞれのgem専用に対応したcopがある場合、rubocop実行時に以下のようなメッセージでおすすめしてくれます。
メッセージに記載されているgemを追加して、研修を進めていきましょう。
```
Tip: Based on detected gems, the following RuboCop extension libraries might be helpful:
  * rubocop-capybara (https://rubygems.org/gems/rubocop-capybara)
  * rubocop-rspec_rails (https://rubygems.org/gems/rubocop-rspec_rails)

You can opt out of this message by adding the following to your config (see https://docs.rubocop.org/rubocop/extensions.html#extension-suggestions for more options):
  AllCops:
    SuggestExtensions: false
```
