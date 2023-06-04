---
slug: playbook-multi-node
id: 0u4okrimnqx5
type: challenge
title: 1ホストから複数ホストへ
teaser: 実際の自動化は複数のホストと対話します。
notes:
- type: text
  contents: |-
    Ansible の真価は、同じ一連のタスクを多くのホストに確実に適用できることです。

    では、node1 と node2 で実行するように apache.yml Playbook を変更するのはどうでしょうか。
- type: text
  contents: これを行うために、Playbook は今後、個々のノードをターゲットにするのではなく、 ノードのグループをターゲットにします。Ansible
    は、インベントリーを介して group 内のすべてのホストを自動的に識別します。
- type: text
  contents: 実際のアプリケーションでの Ansible のベストプラクティスとして、 Playbook は通常、`all` のグループに対処するように記述されます。特定のノードまたはグループへの制限は、
    コマンドラインフラグまたは Ansible コントローラーなどのツールを介して実行時に適用されます。
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
#### 推定所要時間: *3 分*<p>
この課題では、Ansible Playbook を変更して、1 つのホスト (`node1`) だけでなく、ホストのグループ (`web`) をターゲットにして、`web` グループ内のすべてのホストで Playbook を実行します。

☑️ タスク 1 - ホストの変更
===
* *editor* タブがデフォルトで開きます。

エディターで `apache.yml` ファイルを開き、`hosts` 行の値を `node1` から `web` に変更します。

☑️ タスク ２ - apache.yml Ansible Playbook の実行
===

*control* タブ内で、Ansible Playbook `apache.yml` を実行します。

```
cd ansible-files
```
```
ansible-navigator run apache.yml
```

>### **❗️ 警告**
>Playbook タスクは、`node2` でリポジトリーのメタデータを初めて設定するため、完了するまでに 1 分または 2 分かかる場合があります。

☑️ タスク 3 - Web ホストでの Apache の実行確認
===
Ansible Playbook が正常に完了したら、次の Ansible アドホックコマンドを実行して、`Web` グループ内のすべてのホストで Apache (`httpd`) サービスが実行されていることを確認します。

```
ansible web -m ansible.builtin.service_facts | grep httpd.service -A4
```

```
            "httpd.service": {
                "name": "httpd.service",
                "source": "systemd",
                "state": "running",
                "status": "enabled"
            },
--
            "httpd.service": {
                "name": "httpd.service",
                "source": "systemd",
                "state": "running",
                "status": "enabled"
            },
```

✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。


🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-multi-node&assignees=rlopez133)をクリックしてください。

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
