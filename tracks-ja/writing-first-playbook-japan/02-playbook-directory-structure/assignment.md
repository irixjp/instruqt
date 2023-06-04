---
slug: playbook-directory-structure
id: vefhf6f4thm0
type: challenge
title: ディレクトリー構造および Playbook の作成
teaser: 最初の Playbook を記述します。
notes:
- type: text
  contents: |-
    Playbook は、管理対象ホストに実装する必要な設定または手順を記述したファイルです。Playbook は、複雑で時間のかかる管理タスクを、簡単で繰り返し可能なルーチンに変換でき、予測可能で正常な結果を出すことができます。

    Playbook には複数のplayを、playには 1 つまたは複数のタスクを含めることができます。タスクでは、アクションを実行するためにモジュールが呼び出されます。playの目的は、ホストのグループをマッピングすることです。タスクの目標は、それらのホストに対してモジュールを実装することです。
- type: text
  contents: |-
    Playbook は YAML 形式で記述されたテキストファイルなので、以下が必要になります。:

    * 3 つのダッシュ (---) で開始
    * タブではなく、スペースを使用した正しいインデント

    重要な点を以下に示します:

    * `hosts`: タスクを実行する管理対象ホスト
    * `tasks`: Ansible モジュールを呼び出して必要なオプションを渡すことで実行される操作
    * `become`: アドホックコマンドで -b を指定するのと同じように、Playbook での権限昇格。
- type: text
  contents: 適切な Playbook はべき等性を持つため、 Playbook を一度実行してホストを正しい状態にすれば、2回実行しても安全で、 それ以上ホストに変更は加えられないはずです。
tabs:
- title: editor
  type: service
  hostname: control
  path: /editor/
  port: 443
difficulty: basic
timelimit: 1
---
👋 はじめに
===
#### 推定所要時間: *3分*<p>
この課題では、Apache をサーバーにインストールする Playbook を作成します。

☑️ タスク 1 - apache.yml ファイルの作成
===
* *editor* タブがデフォルトで開きます。

エディタータブ内で、ディレクトリー `ansible-files` を開きます。そのディレクトリーで右クリックし、ファイル `apache.yml` を作成します。

☑️ タスク 2 - apache.yml Playbook の定義
===
* *editor* タブがデフォルトで開きます。

ファイル `apache.yml` 内で、次の内容を指定します。

```
---
- name: Apache server installed
  hosts: node1
  become: true
```
Ansible の強みの 1 つは、Playbook の流れを読みやすく理解しやすいことです。以下のように書き出します:

* `name` からのプレイ用に名前が指定されます。
* Playbook を実行するホストを、`hosts:` で定義します。
* `become: true` を使用して、ユーザー権限昇格 (sudo) を有効にします。

☑️ タスク 3 - apache.yml Playbook へのタスクの追加
===

playを定義したら、`node1` ホストにパッケージをインストールするタスクを追加しましょう。`ansible.builtin.package` モジュールを利用して、最新バージョンの Apache パッケージをインストールします。`apache.yml` ファイルを次のように変更して、Apache のインストールを組み込むことができます。

```
---
- name: Apache server installed
  hosts: node1
  become: true
  tasks:
  - name: latest Apache version installed
    ansible.builtin.package:
      name: httpd
      state: latest
```

playの宣言が完了したら、`task` の宣言から始めて、Ansible に自動化させたい特定のタスクを組み込みます。

* タスクに名前が付けられ、タスクのモジュール (`ansible.builtin.package`) が参照されます。
* モジュールのパラメーターが追加されます。
  * `name`: パッケージ名を指定する
  * `state`: パッケージの状態 (present、absent、latest) を定義する

✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、不審な点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-directory-structure&assignees=rlopez133)をクリックしてください。

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
