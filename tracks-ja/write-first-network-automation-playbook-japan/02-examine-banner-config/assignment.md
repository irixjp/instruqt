---
slug: examine-banner-config
id: 3flvx72l8iac
type: challenge
title: バナー設定の確認
teaser: この課題では、Cisco IOSルーターの既存のコンフィグレーションを検証する
notes:
- type: text
  contents: |-
    # 最もシンプルな使用例

    管理コンフィギュレーションは一般的に繰り返し行われるコンフィギュレーション作業であり、すべてのネットワーク機器には、AAA、SSH、NTP、バナーなど、適用しなければならない何らかのゴールデンコンフィギュレーションがある。
    なぜバナーから始めるのか？ ルーターに適用するコンフィギュレーションとしては最もリスクが低い、少なくとも、誤ってVLANを削除したり、トランクポートをシャットダウンしたりするようなことはない。また、1つの変数だけを変更する非常に単純な使用例です: 何をバナーとして送信しよう？
tabs:
- title: VScode editor
  type: service
  hostname: code-server
  path: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel
  port: 80
- title: ansible-controller
  type: terminal
  hostname: code-server
  workdir: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel%2Fansible-files
difficulty: ""
timelimit: 600
---
---
# ステップ1 - バナー設定の確認

Cisco IOSルータにログインし、現在のバナー構成を確認します。

* ansible-controllerのターミナルから、`ssh cisco`を実行する。

```bash
ssh cisco
```

コマンド `show run | s banner` を使って、Ciscoデバイスのバナーの実行コンフィギュレーションを調べる。このコマンドを実行するときは、実行中のバナーコンフィギュレーションがないので、何も出力されないことを期待する。

```
show run | s banner
```

バナーが設定されていないので、空の出力が予想されます。

ルーターCLIを終了して、チャレンジを完了します。

```
exit
```

✅ 次の挑戦
===
タスクを完了したら、下の `Check` ボタンを押して次のチャレンジに進んでください。

🐛 問題に遭遇しましたか？
====

問題が発生した場合、または何かおかしいと気づいた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=network-automation-playbook&title=Issue+with+Writing+First+Network+Playbook+examine-banner-config&assignees=dafmendo) を開いてください。

<style type="text/css" rel="stylesheet">
  .lightbox {
    display: none;
    position: fixed;
    justify-content: center;
    align-items: center;
    z-index: 999;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    padding: 1rem;
    background: rgba(0, 0, 0, 0.8);
    margin-left: auto;
    margin-right: auto;
    margin-top: auto;
    margin-bottom: auto;
  }
  .lightbox:target {
    display: flex;
  }
  .lightbox img {
    /* max-height: 100% */
    max-width: 60%;
    max-height: 60%;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
  }
  h1 {
    font-size: 18px;
  }
    h2 {
    font-size: 16px;
    font-weight: 600
  }
    h3 {
    font-size: 14px;
    font-weight: 600
  }
  p span {
    font-size: 14px;
  }
  ul li span {
    font-size: 14px
  }
</style>
