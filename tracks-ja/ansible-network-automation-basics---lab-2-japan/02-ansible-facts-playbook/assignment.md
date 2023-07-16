---
slug: ansible-facts-playbook
id: iinrfulfkr6b
type: challenge
title: Ansible ファクトの Playbook
teaser: ファクトの収集から始めよう
notes:
- type: text
  contents: |
    # モジュールについての深掘り

    モジュールはAnsibleで実際の作業を行うもので、各プレイブックタスクで実行されるものです。

    - 一般的にPythonで記述されます。
    - モジュールは冪等である
    - モジュールはパラメータという形でユーザーの入力を受ける
- type: text
  contents: |
    # ネットワークモジュール

    ネットワーク・オートメーション用のAnsibleモジュールは、通常、ベンダーのOSの後にモジュール名を付けて参照する。

    - `namespace.collection.facts`
    - `namespace.collection.command`
    - `namespace.collection.config`
    - `namespace.collection.resource`

    例:
    - Arista EOS = `arista.eos.`
    - Cisco IOS/IOS-XE = `cisco.ios.`
    - Juniper Junos = `junipsnetworks.junos.`
- type: text
  contents: |2

    ![picture of facts](https://github.com/IPvSean/pictures_for_github/blob/master/fact_modules.png?raw=true)

    ファクト・モジュールはプラットフォームごとに異なります。 Cisco IOS-XEならcisco.ios.facts、Juniper Junosならjunipernetworks.junos.factsなど。
- type: text
  contents: |-
    # ファクトとは？

    Ansible流の構造化されたデータ

    ![picture of transform facts](https://github.com/IPvSean/pictures_for_github/blob/master/transform_data_facts.png?raw=true)
- type: text
  contents: |2-

    ![Ansible trasnforms pics](https://raw.githubusercontent.com/IPvSean/pictures_for_github/master/transform_data_facts2.png)
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
- title: terminal
  type: terminal
  hostname: code-server
difficulty: basic
timelimit: 600
---
ステップ1 - Playを作る
===

Ansible Playbookは[YAMLファイル](https://yaml.org/)です。YAMLは構造化されたエンコーディングフォーマットであり、（JSONフォーマットのサブセットとは異なり）非常に人間が読みやすいフォーマットです。

- コードサーバータブをクリックします

- Visual Studioのコードで新しいファイルを作成します。 [新規ファイル]をクリックします。

- プレイブックに名前を付けてください： `facts.yml`とします。

- 以下のプレイ定義を facts.yml に入力します:

```
---
- name: gather information from routers
  hosts: cisco
  gather_facts: no
```

それぞれの行について説明:

- 最初の行の `---` は YAML ファイルであることを示す。
- `name:` キーワードはこの特定の Ansible Playbook のオプションの説明である。
- `hosts:`キーワードはインベントリファイルで定義された **cisco** グループに対するこのプレイブックを意味する。
- `gather_facts: no` は自動ファクト収集を停止します。ここでは代わりにモジュールを使います。

ステップ2 - ファクト・タスクの作成
===

以下をプライブックに追加します:

```
  tasks:
    - name: gather router facts
      cisco.ios.facts:
```

> Play とは、タスクのリストです。モジュールは、タスクを実行するためにあらかじめ準備された部品です。

ステップ3 - プレイブックの実行
===

ターミナルタブをクリックします。ansible-navigatorを実行して、Ansible Playbookを実行します:

```
ansible-navigator run facts.yml
```

これは、プレイブックの実行に対する、対話型セッションを開きます。

- プレイブックの出力にズームインするには、0を押すとホスト中心のビューが表示されます。ホストは1つだけなので、オプションは1つだけです。
- cisco の冗長出力を見るには、もう一度 0 を押して、モジュールの戻り値にズームインします。

Cisco ネットワーク・デバイスから収集されたファクトを表示するには、下にスクロールします。

完了
===
課題２が完了しました！



