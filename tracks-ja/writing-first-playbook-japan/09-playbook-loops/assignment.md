---
slug: playbook-loops
id: ona0gczti5fg
type: challenge
title: ループの使用
teaser: 1 つのステップが十分ではない場合
notes:
- type: text
  contents: ループを使用すると、同じタスクを何度も繰り返すことができます。たとえば、 複数のユーザーを作成するとします。Ansible ループを使用すると、以下が可能になります。
    これは、1 つのタスクで行います。
- type: text
  contents: |-
    ループは、基本的なリスト以外にも反復できます。たとえば、対応するグループを持つユーザーのリストがある場合、ループはそれらに対しても反復できます。

    ループの詳細については、[Ansible ループのドキュメント](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html) を参照してください。
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
#### 推定所要時間: *5 分*<p>
この課題では、`node1` で 3 つの新しいユーザーを生成する単純なループを作成します


☑️ タスク 1 - 新しい Playbook の作成
===
* *editor* タブがデフォルトで開きます。

*エディター* タブを開き、ファイル `loop_users.yml` を作成します。これは、右クリックして 新しいファイルを選択するだけで実行できます。

`loop_users.yml` 内に、次のコンテンツを追加します。次の Playbook では、`ansible.builtin.user` モジュールを利用して `node1` ホストにユーザーを作成します。

`name:` ラベル内で `{{ item }}` というラベルの付いた特別な値を使用する方法に注意してください。この変数 `item` は、`loop:` ステートメントの下にある値に置き換えられます。

```
---
- name: Ensure users
  hosts: node1
  become: true

  tasks:
    - name: Ensure three users are present
      ansible.builtin.user:
        name: "{{ item }}"
        state: present
      loop:
         - dev_user
         - qa_user
         - prod_user
```

☑️ タスク 2 - loop_users.yml Playbook の実行
===

*control* タブ内で、ディレクトリーを `ansible-files` に変更し、`loop_users.yml` Playbook を実行します。

```
cd ansible-files
```

```
ansible-navigator run loop_users.yml
```
```
PLAY [Ensure users] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [node1]

TASK [Ensure three users are present] ******************************************
changed: [node1] => (item=dev_user)
changed: [node1] => (item=qa_user)
changed: [node1] => (item=prod_user)

PLAY RECAP *********************************************************************
node1                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
Playbook の概要:

* loop キーワードは、与えられたリストの要素回数分だけモジュールを実行します。
* リストの値は先頭から取り出されて `{{ item }}` という変数に格納されます。
* `ansible.builtin.user` モジュールの `name`パラメーターには `{{ item }}` が指定されているので、ループのたびにリストの要素が順に格納されていることになります。


✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-loops&assignees=rlopez133)をクリックしてください。

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
