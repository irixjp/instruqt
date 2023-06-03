---
slug: playbook-conditionals
id: r5p8cj955kkw
type: challenge
title: 実行内容の決定 - 条件式の使用
teaser: 条件をもとに自動化でルートを決定してみましょう。
notes:
- type: text
  contents: |-
    Playbook では、Ansible 条件を使用して、特定の条件が満たされたときにタスクまたはプレイを実行できます。条件を実装するには、`when` ステートメントを使用し、その後にテストする条件を指定する必要があります。条件は、次のような使用可能な演算子の 1 つを使用して表現されます


    |      |                                                                        |
    | ---- | ---------------------------------------------------------------------- |
    | \==  | 2 つのオブジェクトが等しいかどうかを比較します。                       |
    | \!=  | 2 つのオブジェクトを非等価性と比較します。                             |
    | \>   | 左辺が右辺より大きい場合は true。                   |
    | \>=  | 左辺が右辺より大きいか等しい場合は true。            |
    | \<   | 左辺が右辺より低い場合は true。                    |
    | \<=  | 左辺が右辺より小さいか等しい場合は true。           |
tabs:
- title: editor
  type: service
  hostname: control
  path: /editor/
  port: 443
- title: control
  type: terminal
  hostname: control
difficulty: basic
timelimit: 1
---
👋 はじめに
===
#### 推定所要時間: *10 分*<p>
この課題では、メール転送エージェント (MTA) Postfix をバックエンドデータベースに追加してステータスメールを送信する Playbook を作成します。

☑️ タスク 1 - ホストインベントリーファイルの更新
===
* *editor* タブがデフォルトで開きます。

*editor* タブの `ansible-files` ディレクトリー内で、`hosts` ファイルを開き、以下を追加します。

```
[web]
node1
node2

[database]
node3
```

☑️ タスク 2 - 新しい Playbook の作成
===

`Web` グループホスト (`node1` および `node2`) に `postfix` パッケージをインストールし、ホストの `database` グループ (`node3`) に `postgresql` パッケージをインストールする、`extended_services.yml` というラベルの付いた Playbook を作成します。

`ansible-files` ディレクトリー内で、右クリックして New File を選択し、`extended_services.yml` ファイルを作成します。

>### **❗️注意**
>タスクを実行する特定のグループを指定する `when` 条件内で使用される、`inventory_hostname` というラベルの付いた Ansible ファクト変数に注意してください。

`extended_services.yml` ファイル内で、以下の内容を入力します。

```
---
- name: Install extended services
  hosts: all
  become: true
  tasks:
    - name: Install Postfix
      ansible.builtin.package:
        name: postfix
        state: latest
      when: inventory_hostname in groups["web"]
```

次に、グループデータベースのノードにデータベースをインストールするタスクを追加します:

```
    - name: Install database in corresponding group
      ansible.builtin.package:
        name: postgresql
        state: latest
      when: inventory_hostname in groups["database"]
```

☑️ タスク 3 - Playbook の実行
===

*control* タブ内で、Playbook を実行します:

```
cd ansible-files
```
```
ansible-navigator run extended_services.yml
```

```
PLAY [Install extended services] ***********************************************

TASK [Gathering Facts] *********************************************************
ok: [node3]
ok: [node1]
ok: [node2]

TASK [Install Postfix] *********************************************************
skipping: [node3]
changed: [node2]
changed: [node1]

TASK [Install database in corresponding group] *********************************
skipping: [node1]
skipping: [node2]
changed: [node3]

PLAY RECAP *********************************************************************
node1                      : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
node2                      : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
node3                      : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

Playbook を実行したときに `スキップ` に気付きましたか?
これは、`hosts` インベントリーファイル内の `hosts:` ラベルが `all` に設定されていても、タスクの特定のホストを対象とする条件付きの `when` ステートメントが原因です。

✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-conditionals&assignees=rlopez133)をクリックしてください。

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
