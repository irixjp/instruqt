---
slug: handlers
id: ypsuylolajiv
type: challenge
title: ハンドラー
teaser: 通知を忘れないでください。
notes:
- type: text
  contents: タスクがシステムに変更を加える場合、 追加のタスクを実行する必要がある場合があります。たとえば、サービス設定の変更 その後、ファイルにより、変更した設定のためにサービスの再起動が必要になる場合があります。
    有効になります。
- type: text
  contents: ここで Ansible のハンドラーが登場します。ハンドラーは非アクティブと見なすことができます。 notify ステートメントを使用して明示的に呼び出された場合にのみトリガーされるタスク。
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
この課題では、ハンドラーを使用して、`httpd.conf` ファイルが変更されたときに Apache の再起動を通知します。


☑️ タスク 1 - 新しい Playbook の作成
===
* *editor* タブがデフォルトで開きます。

*editor* タブを開き、ファイル `httpd_conf.yml` を作成します。これは、右クリックして 新しいファイルを選択するだけで実行できます。

`httpd_conf.yml` 内に、次のコンテンツを追加します。以下の Playbook は、`Web` グループ内のすべてのホストで Apache の設定ファイル `/etc/httpd/conf/httpd.conf` を管理します。ファイルが変更されると、Apache を再起動します。

```
---
- name: manage httpd.conf
  hosts: web
  become: true
  tasks:
  - name: Copy Apache configuration file
    copy:
      src: httpd.conf
      dest: /etc/httpd/conf/
    notify:
      - restart_apache
  handlers:
    - name: restart_apache
      service:
        name: httpd
        state: restarted
```

Playbook について:

* `notify` セクションは、コピータスクが実際にファイルを変更した場合にのみハンドラーを呼び出します。そうすれば、Playbook が実行されるたびにではなく、必要な場合にのみサービスが再起動されます。

* `handlers` セクションは、通知時にのみ実行されるタスクを定義します。

☑️ タスク 2 - httpd.conf ファイルの制御ノードへのコピー
===

*control* タブ内で、`/etc/httpd/conf/httpd.conf` ファイルを `node1` から `/home/rhel/ansible-files/files/` の場所にコピーします。

```
scp node1:/etc/httpd/conf/httpd.conf /home/rhel/ansible-files/files/.

ls -l /home/rhel/ansible-files/files/
```

☑️ タスク 3 - httpd_conf.yml Playbook の実行
===

*control* タブ内で、ディレクトリーを `ansible-files` に変更し、`httpd_conf.yml Playbook` を実行します。

```
cd ansible-files
```

```
ansible-navigator run httpd_conf.yml
```


出力で何か気づきましたか?

何も変更されていないため、Playbook が実行され、PLAY RECAP に `changed` 行が表示されないことがわかります。

☑️ タスク 4 - httpd.conf ファイルの変更
===

*editor* タブ内で、`ansible-files/files/httpd.conf` を変更し、`ansible-files/files/httpd.conf` の `Listen 80` 行を次のように変更します:

```
Listen 8081
```

>### **❗️ 注意**
>エクスプローラーの更新ボタンで更新すると、エディター内にファイルが表示される場合があります。

☑️ タスク 5 - httpd_conf.yml Playbook の実行
===

*control* タブ内で、Playbook を再度実行します。

```
ansible-navigator run httpd_conf.yml
```


playbook を再び実行します。これで、Ansible の出力はもっと興味深いものになるはずです:

* `httpd.conf` はコピーされているはずです
* ハンドラーは Apache を再起動しているはずです

☑️ タスク 6 - ポート 8081 でリッスンしている Apache の確認
===

*control* タブ内で、次の `curl` コマンドを実行します

```
curl http://node1
```

```
curl: (7) Failed to connect to node1 port 80: Connection refused
```

```
curl http://node1:8081
```
```
<body>
<h1>This is a production webserver, take care!</h1>
</body>
```


✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+handlers&assignees=rlopez133)をクリックしてください。

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
