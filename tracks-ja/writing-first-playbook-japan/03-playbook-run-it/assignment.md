---
slug: playbook-run-it
id: ql3f5nskq0r4
type: challenge
title: 実行
teaser: 仕組みの確認
notes:
- type: text
  contents: |-
    前回の課題では、Playbook を作成しました。では起動しましょう。

    コマンド `ansible-navigator` を使用してこれを行います (このコマンドは、コマンドラインでの Ansible の中心的なコマンドの 1 つです)。
- type: text
  contents: タスク中に、`ansible-navigator` が `hosts` ファイルの場所を 実際にどのように認識しているか疑問に思うかもしれません。
    これは、この環境で事前に作成されたファイル `/home/rhel/ansible-files/ansible-navigator.yml` で設定されています。もしお時間があればご覧ください。簡単に理解できるはずです。
tabs:
- title: control
  type: terminal
  hostname: control
difficulty: basic
timelimit: 1
---
👋 はじめに
===
#### 推定所要時間: *5分*<p>
この課題では、`ansible-navigator` ツールを使用してコントロールノードから Ansible Playbook を実行します。

☑️ タスク 1 - apache.yml Ansible Playbook の実行
===
* *control* タブはデフォルトで開いています。

*control* タブで、`ansible-files` ディレクトリーに移動します。

```
cd ansible-files
```

Playbook を実行します。

```
ansible-navigator run apache.yml
```
>### **❗️ 警告**
>Playbook タスクは、初めてリポジトリーメタデータを入力するため、完了するまでに 1 ~ 2 分かかる場合があります。

>### **❗️ 注意**
>`-i hosts` オプションは、`ansible-navigator.yml` ファイルがすでにインベントリーのデフォルトの場所を設定しているため、必要ありません。

出力はエラーを報告するべきではありませんが、実行されたタスクの概要と、実行されたことを要約したプレイの要約を提供する必要があります。

```
ansible-navigator run apache.yml
```
```
PLAY [Apache server installed] *************************************************

TASK [Gathering Facts] *********************************************************
ok: [node1]

TASK [latest Apache version installed] *****************************************
changed: [node1]

PLAY RECAP *********************************************************************
node1                      : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
各 Ansible playの開始時に自動的に実行される `Gathering Facts` というラベルの付いた組み込みタスクがあります。管理対象ノードに関する情報を収集します。

今後の課題では、これについてさらに詳しく説明します。

☑️ タスク 2 - Apache がインストールされていることの確認
===

`apache.yml Playbook` は、ホスト `node1` に Apache (`httpd` パッケージ) をインストールします。パッケージが実際にインストールされた結果を確認する簡単な方法は、Ansible アドホックコマンドを使用して結果を確認することです。

```
ansible node1 -m ansible.builtin.shell -a "rpm -qi httpd"
```

```
node1 | CHANGED | rc=0 >>
Name        : httpd
Version     : 2.4.37
Release     : 47.module+el8.6.0+15654+427eba2e.2
Architecture: x86_64
Install Date: Thu 28 Jul 2022 12:25:23 AM UTC
Group       : System Environment/Daemons
Size        : 4499603
License     : ASL 2.0
Signature   : RSA/SHA256, Thu 16 Jun 2022 11:39:02 AM UTC, Key ID 199e2f91fd431d51
Source RPM  : httpd-2.4.37-47.module+el8.6.0+15654+427eba2e.2.src.rpm
Build Date  : Wed 15 Jun 2022 12:27:53 PM UTC
Build Host  : x86-64-02.build.eng.rdu2.redhat.com
Relocations : (not relocatable)
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
Vendor      : Red Hat, Inc.
URL         : https://httpd.apache.org/
Summary     : Apache HTTP Server
Description :
The Apache HTTP Server is a powerful, efficient, and extensible
web server.
```

これはモジュール (-m) `ansible.builtin.shell` と、モジュール引数 (-a) を使って、`node1` で `rpm -qi httpd` というコマンドを実行します。

出力には、パッケージの名前、バージョン、その他の詳細が一覧表示さ れます。



☑️ タスク 3 - 動作の冪等性
===

Ansible Playbook をもう一度実行し、出力を元の出力と比較します。タスクが `changed` から `ok` に変化し、色が `黄色` から `緑色` に変わることに気付くでしょう。さらに、*PLAY RECAP* も異なり、Ansible によって行われた変更を簡単に見つけることができます。

```
ansible-navigator run apache.yml
```

```
PLAY [Apache server installed] *************************************************

TASK [Gathering Facts] *********************************************************
ok: [node1]

TASK [latest Apache version installed] *****************************************
ok: [node1]

PLAY RECAP *********************************************************************
node1                      : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

何がおきているのか？

これは冪等性が理由で発生します。Ansible Playbook は何度も実行できますが、`node1` に `httpd` パッケージがインストールされていないのはこの時だけであるため、変更を行うのは初回のみです。パッケージがインストールされると、Ansible はこれを認識し、*OK* のステータスを返し、パッケージが実際に存在することを知らせます。

✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-run-it&assignees=rlopez133)をクリックしてください。

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
