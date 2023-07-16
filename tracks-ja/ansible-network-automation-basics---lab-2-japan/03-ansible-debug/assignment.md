---
slug: ansible-debug
id: 836an6vusqeq
type: challenge
title: デバッグ・モジュールの使用
teaser: デバッグ・モジュールを使ったファクトの使用方法を学ぶ
notes:
- type: text
  contents: |-
    # 出力の表示 - "debug "モジュール

    debugモジュールは、ほとんどのプログラミング言語における "print "文のように使われる。
    変数へのアクセスは "{{ }}" を使ってアクセスします。

    ![picture of debug tasks](https://github.com/IPvSean/pictures_for_github/blob/master/debug.png?raw=true)
- type: text
  contents: |-
    # Ansible facts での作業

    ![display vlans picture](https://github.com/IPvSean/pictures_for_github/blob/master/display_vlans.png?raw=true)
- type: text
  contents: |-
    # プレイブックの実行

    ![display vlans picture](https://github.com/IPvSean/pictures_for_github/blob/master/navigator_output.png?raw=true)
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

    ラボのセットアップが完了したら、このウィンドウの右下にある緑のスタートボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックします。
tabs:
- title: code-server
  type: service
  hostname: code-server
  path: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel
  port: 80
- title: Terminal
  type: terminal
  hostname: code-server
difficulty: basic
timelimit: 600
---
ステップ1 - デバッグタスクの使用
===

ルーターのOSバージョンとシリアル番号を表示するタスクを2つ追加します。

code-serverタブをクリックし、`facts.yml` playbookに以下のタスクを追加します:

```
    - name: display version
      debug:
        msg: "The IOS version is: {{ ansible_net_version }}"

    - name: display serial number
      debug:
        msg: "The serial number is: {{ ansible_net_serialnum }}"
```

ステップ2 - stdoutでプレイブックを実行する
===

ターミナルタブをクリックします。ansible-navigatorと-mode stdoutを使用してplaybookを再実行します。

実行するコマンドは以下になります:

```
ansible-navigator run facts.yml --mode stdout
```

20行にも満たない「コード」で、バージョンとシリアル番号の収集を自動化しました。これを本番のネットワークに対して実行するとしたらどうでしょうか？いつでも最新の実用的な"ファクト"を手にすることができます。

要点
===

- `ansible-navigator:doc`コマンドは、インターネットに接続しなくてもドキュメントにアクセスできるようにします。このドキュメントは、コントロール・ノード上のAnsibleのバージョンにも対応しています。
- `cisco.ios.facts`モジュールは、Cisco IOS固有の構造化データを収集します。各ネットワークプラットフォームに関連するモジュールがある。例えば、Juniper Junos には `junipernetworks.junos.facts` があり、Arista EOS には `arista.eos.facts` がある。
- `debug`モジュールを使うと、Ansible Playbook がターミナルウィンドウに値を出力することができる。
