---
slug: checking-environment
id: vqdbzwkrtuwp
type: challenge
title: 最小のPlaybookの開発と実行
teaser: ここでは小さな Playbook を作成して実行します。
notes:
- type: text
  contents: |
    # MVP = Minimum Viable Product チャレンジ
    Red Hat Ansible Automation Platform（AAP） を活用することで、シンプルに自動化を開発し、その自動化を使ってセルフサービス・APIをユーザーに適用できるようになります。以下の流れで最新の自動化手法について学習・体験していきます。

    5つのステップで作業を進めていきます。
    1. **→Playbook の作成（自動化の実装）←**
    2. 作成したPlaybookをセルフサービス実行
    3. 自動化にパラメーターを与える
    4. セルフサービス同士を連結して新たなサービスを作成・実行
    5. API を用いた外部システムとの連携

    \> をクリックしてページを進めてください。
- type: text
  contents: |
    # 用語: Playbook
    Ansible において「何をするか」を指示するスクリプトです。YAML形式で記述し、シンプルな構文で記述可能です。

    Playbookのサンプル
    ```
    - hosts: all
      tasks:
      - name: サービスの再起動
        ansible.builtin.systemd:
          state: restarted
          name: httpd
    ```
    \> をクリックしてページを進めてください。
- type: text
  contents: |
    # ステップ1. Playbook の作成
    まず最初に以下のPlaybookを作成し、テストサーバーに対して実行します。

    - サーバーのログを取得する
    - サービスを再起動する

    環境が準備が整ったら、右下の「start」ボタンを押して演習を開始します。
tabs:
- title: Controller CLI
  type: terminal
  hostname: controller
- title: Host01 CLI
  type: terminal
  hostname: host01
- title: Editor
  type: service
  hostname: controller
  path: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel
  port: 443
- title: Dashboard
  type: service
  hostname: controller
  port: 443
difficulty: basic
timelimit: 1200
---
以下の手順に従い、演習環境を進めてください。

> 左側のウインドのロードに少し時間がかかる場合があります。表示されるまで少々お待ち下さい。

↓をクリックすると次の手順が展開されます。

☑️ タスク1: 環境の確認
===
現在、この演習環境には２つのサーバーが存在しています。

| サーバー   | 用途                                                             |
|------------|------------------------------------------------------------------|
| Controller | Ansible がインストールされており、自動化を実行するサーバーです。 |
| host01     | 自動化の対象となるサーバーです。                                 |


それぞれのサーバーにアクセスするには、画面左上のタブから切り替えることが可能です。

| タブ名           | 用途                                                                           |
|------------------|--------------------------------------------------------------------------------|
| `Controller CLI` | Controller のターミナルへアクセスできます。                                    |
| `Host01 CLI`     | host01 のターミナルへアクセスできます。                                        |
| `Editor`         | Controller 上で起動してる Web版のVSCodeへアクセスできます。                    |
| `Dashboard`      | Controller 上で起動している Ansible Automation Controller へアクセスできます。 |

![instruqt\_tab.png](../assets/instruqt_tab.png)

> Note: これらのタブがうまく表示されないときは、タブ表示箇所の右側に表示されているリロードマーク ↻ をクリックしてください。

いくつかの操作を実施してみましょう。以下のコマンドを演習画面の左上部のタブの `Controller CLI` から実行し、Controller と host01 が疎通できることを確認します。

```
ping -c 5 host01
```
上記は ping を host01 へ5回送信します。

```
ssh host01 hostname
```
上記は ssh を使って host01 上で hostname コマンドを実行します。

```
curl http://host01/index.html
```
上記は curl コマンドを使用し host01 で稼働している web サーバーに http アクセスを行っています。`This is host01` というページが表示されるはずです。


☑️ タスク2: Playbook の作成
===
では実際に Playbook を作成していきます。ここでは Playbook の構文の意味がわからない部分もあるかと思いますが、この演習では「体験」を重視するため、詳細な構文の解説は行いません。サンプル通りコピーして作成するだけで十分です。

「このくらいの記述で、こんな自動化ができるのか」というのを体験していただければここでは十分です。

> Note: Playbook の構文についての詳細を学習したい方は、別コースが準備されていますのでそちらを実施してください。


演習画面の左上部のタブから `Editor` を選択し、VSCode を起動してください。ここではファイルの編集を行うことが可能です。

左ペインの `EXPLORER` で `RHEL` フォルダの内容が展開されています。このRHELフォルダ内に Playbookを配置していきます。ファイルを新規作成するには、 `EXPLORER` 上で右クリックして「New File...」を選択します。

以下のファイル名と内容で、ファイルを3つ作成してください。このときにファイルのインデント（段差げ）がサンプルと同じようになるように注意してください。

1つ目 `nginx_stop.yaml` nginx を停止する Playbook
```
- hosts: all
  become: true
  tasks:
  - name: stop nginx
    ansible.builtin.service:
      name: nginx
      state: stopped
```

2つ目 `nginx_start.yaml` nginx を起動するPlaybook
```
- hosts: all
  become: true
  tasks:
  - name: start nginx
    ansible.builtin.service:
      name: nginx
      state: started
```

3つ目 `get_logfile.yaml` /var/log/messages の内容を取得する
```
- hosts: all
  become: true
  tasks:
  - name: get /var/log/messages
    ansible.builtin.shell:
      cmd: tail -20 /var/log/messages
    register: output
  - name: show log file
    ansible.builtin.debug:
      msg: "{{ output.stdout_lines }}"
```

> Note: 実はサービスの起動/再起動は `state: restarted` とすることで1つのPlaybookにまとめることが可能ですが、ここでは演習のために2つに分割して記述しています。


☑️ タスク3: Playbook の実行(サービスの停止)
===
それでは3つの Playbook を順に実行して動作を確認してみましょう。Playbook をコマンドラインから実行するには `ansible-navigator` コマンドを利用します。

まず `Controller CLI` タブへ移動してください。Playbook を実行する前に、nginx が稼働していることを確認し、その後で nginx を停止してアクセスできなくなることを確認します。

host01 への http アクセスを確認（`This is host01` が表示される）
```
curl http:/host01/index.html
```

サービスの停止を実行
```
ansible-navigator run nginx_stop.yaml
```

> Note: 初回のコマンド実行には少し時間がかかります。これは ansible-navigator コマンドが Playbook を実行するためのコンテナ環境をダウンロードするためです。

以下のように出力されれば正常に実行が完了しております。
```
(省略)
PLAY [all] *****************************************************************

TASK [Gathering Facts] *****************************************************
ok: [host01]

TASK [stop nginx] **********************************************************
changed: [host01]

PLAY RECAP *****************************************************************
host01 : ok=2 changed=1 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
```

再度、host01 への http アクセスを確認（アクセスできないことを確認）
```
curl http://host01/index.html
```
ここで `Failed to connect to host01 port 80: Connection refused` になれば Playbook が正常に動作し、nginx が停止されたことが確認できます。


☑️ タスク4: Playbook の実行(サービスの起動、ログの表示)
===
では残りの Playbook を実行してみしょう。先程 nginx を停止しましたので、今度は起動する Playbook を実行します。

サービスの起動を実行
```
ansible-navigator run nginx_start.yaml
```

host01 への http アクセスを確認（アクセスが復旧したことを確認）
```
curl http://host01/index.html
```

/var/log/messages の内容を表示（ログの内容が表示されることを確認）
```
ansible-navigator run get_logfile.yaml
```

ログ表示の例（抜粋）：
```
TASK [show log file] ***********************************************************
ok: [host01] => {
    "msg": [
        "Aug 23 05:03:09 host01 systemd[1]: Starting User runtime directory /run/user/1001...",
        "Aug 23 05:03:09 host01 systemd-logind[1337]: New session c1 of user rhel.",
        "Aug 23 05:03:09 host01 systemd[1]: Started User runtime directory /run/user/1001.",
        "Aug 23 05:03:09 host01 systemd[1]: Starting User Manager for UID 1001...",
        "Aug 23 05:03:09 host01 systemd[1901]: Starting D-Bus User Message Bus Socket.",
        "Aug 23 05:03:09 host01 systemd[1901]: Started Mark boot as successful after the user session has run 2 minutes.",
        "Aug 23 05:03:09 host01 systemd[1901]: Reached target Paths.",
        "Aug 23 05:03:09 host01 systemd[1901]: Reached target Timers.",
        "Aug 23 05:03:09 host01 systemd[1901]: Listening on D-Bus User Message Bus Socket.",
        "Aug 23 05:03:09 host01 systemd[1901]: Reached target Sockets.",
        "Aug 23 05:03:09 host01 systemd[1901]: Reached target Basic System.",
        "Aug 23 05:03:09 host01 systemd[1901]: Reached target Default.",
```

☑️ まとめ
===
本演習の流れで Ansible の自動化の開発が進みます。

1. Playbook の開発
2. コマンドラインから Playbook を実行し、動作のテストを行う
3. 1と2を繰り返し、Playbook を完成させる

次の演習では、これらの Playbook をセルフサービス化、API化して、他のメンバーから利用可能にしていきます。



