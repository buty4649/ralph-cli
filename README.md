# ralph-cli
CLI tool for Ralph (https://ralph.allegro.tech/)

## Install

```
gem install ralph-cli
```

## Usage

### URLの設定

`$RALPH_URL` 環境変数にRalphのURLを設定します。

```
$ export RALPH_URL=<your Ralph URL>
```

### トークンの発行

APIで使用するトークンを発行します。ユーザ名とパスワードに問題がなければトークンが表示されます。

```
$ ralph token <your username>
Password: <your password>
```

トークンは`$RALPH_TOKEN`環境変数経由で参照するので設定します。

```
$ export RALPH_TOKEN="<your token>"
```

### 複数POST

`ralph <subcommand> post`を使ってアイテムを登録できますが、`--file`オプションを使って複数のアイテムを一括して登録できます。

```
$ cat items.json
[
  {
    "name": "test1"
  },
  {
    "name": "test2"
  }
]
$ ralph post --file items.json
```
