---
slug: dashcoard-and-console
id: xtbitnhbiefs
type: challenge
title: ダッシュボードとコンソールの操作の確認
teaser: 本トラックで Instruqt を使ったハンズオン環境の動作を確認することが可能です。
notes:
- type: text
  contents: Instruqt を使ったハンズオンでは Web ブラウザのみで様々な演習が可能です。
tabs:
- title: Controller Dashboard
  type: service
  hostname: controller
  port: 443
- title: Controller CLI
  type: terminal
  hostname: controller
- title: editor
  type: service
  hostname: controller
  path: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel
  port: 443
difficulty: basic
timelimit: 600
---
☑️ AAP ダッシュボードの動作確認
===
演習画面の左上部のタブから `Controller Dashboard` を選択します（デフォルトで選択されているはずです）

Red Hat Ansible Automation Platform のログイン画面が表示されますので、以下の情報でログインしてください。

* Username: `admin`
* Password: `ansible123!`

ログインに成功すれば動作確認は終了です。

> Note: ログインに問題がある場合は、 `*.play.instruqt.com` への通信が遮断されていないかを確認してください。

☑️ コンソール操作の動作確認
===
演習画面の左上部のタブから `Controller CLI` を選択します。

`Controller CLI` ではブラウザ上でサーバー上のコマンドを実行することが可能です。

通常の Linux 環境のように `ls` や `hostname` コマンドを実行して、ブラウザ上でコマンドが実行できることを確認してください。

> Note: コマンド実行できない、何も表示されない場合はお使いのNW環境で WebSocket 通信が遮断されている可能性があります。

☑️ エディタの動作確認
===
演習画面の左上部のタブから `editor` を選択します。VSCode の画面が表示されます。

左ペインでは `EXPLORER`で `RHEL` フォルダの内容が展開されています。このRHELフォルダ上に新規ファイル `test.txt` を作成してください。

ファイルを作成するには、展開されているRHELフォルダ内の空きスペースで「New File ...」を選択します。

ファイルを作成すると、画面右側でファイルの編集が行なえますので、適当な文字列を書き込み保存してください（Windows の場合は Ctrl + s, Mac の場合は Command + s）

ファイルを保存したら、`Controller CLI` タブへ移動し、コマンドからファイルの中身を確認してください。

```
cat test.txt
```

自分が編集したファイルの中身が確認できれば動作確認は終了です。


☑️ 動作確認の終了
===
上記の動作確認が終了したら本ページを閉じてください。
