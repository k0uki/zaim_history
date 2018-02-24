# ZaimHistory

Web版Zaimをスクレイピングして入力履歴を表示します。出力フォーマットは表形式、CSVから選択することができます。

## Installation

```
bundle install
```
で依存しているgemをインストールすることができます

## Usage

当月の履歴取得は下記コマンドで行うことができます
```
exe/zaim_history fetch
```
メールアドレス、パスワードはオプションとして渡すことができます。取得する年月を変更する場合はmonthオプションで指定してください。
```
exe/zaim_history fetch --month=201802
```

CSV出力する場合は、formatオプションで指定してください。ファイルに保存する場合はリダイレクトを利用できます。
```
exe/zaim_history fetch --month=201802 --format=csv --mail=メールアドレス --password=パスワード > 201802.csv
```

その他オプションはhelpコマンドで確認できます
```
exe/zaim_history help fetch
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
