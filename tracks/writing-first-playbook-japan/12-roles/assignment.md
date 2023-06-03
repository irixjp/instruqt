---
slug: roles
id: cvrccbdyybn7
type: challenge
title: ロール
teaser: Playbook の作成を簡素化するフレームワーク
notes:
- type: text
  contents: |-
    Ansible ロールには、8 つの主要な標準ディレクトリーを含む定義済みのディレクトリー構造があります。各ロールには、これらのディレクトリーを少なくとも 1 つ含める必要があります。ロールが使用しないディレクトリーは省略できます。

    デフォルトでは、Ansible はロール内の各ディレクトリーで、関連するコンテンツの main.yml ファイルを検索します。

    次の課題では、ロールを作成し、ロールツリー構造を確認して、`node2` に Apache VirtualHost を作成します。
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
これらの課題全体で行ってきたように、1 つのファイルに Playbook を作成することは可能ですが、最終的にはファイルを再利用して整理を開始する必要があります。この課題では、指定したノードに Apache VirtualHost を作成する Ansible ロールを作成します。

☑️ タスク 1 - 基本的なロールのディレクトリー構造の作成
===

Ansible は、プロジェクトディレクトリー内の `roles` というサブディレクトリーでロールを探します。これは、Ansible 設定でオーバーライドできます。各ロールには独自のディレクトリーがあります。新しいロールの作成を容易にするために、ツール `ansible-galaxy` を使用できます。

>### **💡ヒント**
>Ansible Galaxy は、Ansible コンテンツを検索、再利用、共有するためのハブです。`ansible-galaxy` は、Ansible Galaxy との対話に役立ちます。今のところ、ディレクトリー構造を構築するためのヘルパーとして使用します。

*controle* タブ内で、`ansible-files` の下に `roles` ディレクトリーを作成します。

```
cd ansible-files
```
```
mkdir roles
```
`roles` ディレクトリーが作成されたら、`ansible-galaxy` を使用して `apache_vhost` というラベルの付いたロールを作成します

```
ansible-galaxy init --offline roles/apache_vhost
```

☑️ タスク 2 - apache_vhost ロールのディレクトリー構造の表示
===

*control* タブ内で、`tree` コマンドを使用してロールディレクトリーとそのコンテンツを確認します。

```
tree roles
```
```
roles/
└── apache_vhost
    ├── defaults
    │   └── main.yml
    ├── files
    ├── handlers
    │   └── main.yml
    ├── meta
    │   └── main.yml
    ├── README.md
    ├── tasks
    │   └── main.yml
    ├── templates
    ├── tests
    │   ├── inventory
    │   └── test.yml
    └── vars
        └── main.yml
```

☑️ Task 3 - Edit the tasks/main.yml file
===

以前は、すべてのタスクを Ansible Playbook 自体に含めていました。Ansible Roles では、`tasks/main.yml` ファイル内にタスクを含めます。このファイルにはタスクのみが含まれており、完全な Playbook ではありません。

この課題では、`main.yml` ファイルに次のタスクが含まれています。

* `httpd` がインストールされていることを確認する
* `httpd` が起動し、有効になっていることを確認する
* HTML コンテンツを Apache ドキュメントルートに配置する
* vhost の設定用のテンプレートをインストールする

`roles/apache_vhost/tasks/main.yml` ファイルを編集します:

```
---
# tasks file for roles/apache_vhost
- name: install httpd
  ansible.builtin.package:
    name: httpd
    state: latest

- name: start and enable httpd service
  ansible.builtin.service:
    name: httpd
    state: started
    enabled: true
```
>### **❗️注意**
>main.yml ファイルのタスクはファイルの先頭から始まり (スペースなし)、Playbook の詳細 (ホスト、変数など) は存在しません。

これまで追加されたタスクは以下を行います。

* `ansible.builtin.package` モジュールを使用して `httpd` パッケージをインストールする
* `ansible.builtin.service` モジュールを使用して `httpd` を有効にして起動する

☑️ タスク 4 - tasks/main.yml ファイルへのさらなるタスクの追加
===

次に、さらに 3 つのタスクを追加して vhost ディレクトリー構造を確保し、html コンテンツをホストの index.html ファイルにコピーし、テンプレートモジュールを使用して jinja2 テンプレートから vhost 設定を作成します。

```
- name: ensure vhost directory is present
  ansible.builtin.file:
    path: "/var/www/vhosts/{{ ansible_hostname }}"
    state: directory

- name: deliver html content
  ansible.builtin.copy:
    src: web.html
    dest: "/var/www/vhosts/{{ ansible_hostname }}/index.html"

- name: template vhost file
  template:
    src: vhost.conf.j2
    dest: /etc/httpd/conf.d/vhost.conf
    owner: root
    group: root
    mode: 0644
  notify:
    - restart_httpd
```

ハンドラー (`restart_httpd`) に気付きましたか?

☑️ タスク 5 - restart_httpd ハンドラーの作成
===

`roles/apache_vhost/handlers/main.yml` 内で、コンテンツを `restart_httpd` ハンドラータスクに追加します。

```
---
# handlers file for roles/apache_vhost
- name: restart_httpd
  service:
    name: httpd
    state: restarted
```

☑️ タスク 6 - web.html ファイルの作成
===

Web サーバーによってサービスされる HTML コンテンツを作成します。

ロール `files` の src ディレクトリーに `web.html` ファイルを作成します:

```
echo 'simple vhost index' > ~/ansible-files/roles/apache_vhost/files/web.html
```
☑️ タスク 7 - web.html ファイルの作成
===

ロールのテンプレ ートサブディレクトリー (`~/ansible-files/roles/apache_vhost/templates`) に `vhost.conf.j2` テンプレートファイルを作成します。

```
# {{ ansible_managed }}

<VirtualHost *:8081>
    ServerAdmin webmaster@{{ ansible_fqdn }}
    ServerName {{ ansible_fqdn }}
    ErrorLog logs/{{ ansible_hostname }}-error.log
    CustomLog logs/{{ ansible_hostname }}-common.log common
    DocumentRoot /var/www/vhosts/{{ ansible_hostname }}/

    <Directory /var/www/vhosts/{{ ansible_hostname }}/>
  Options +Indexes +FollowSymlinks +Includes
  Order allow,deny
  Allow from all
    </Directory>
</VirtualHost>
```

☑️ タスク 8 - Ansible Playbook の作成
===

ロールが完成したら、ロールに対して実行される Ansible Playbook を作成し、すべてが期待どおりに機能することを確認します。

*エディター* タブ内で、ディレクトリー `ansible-files` に `test_apache_role.yml` というラベルの付いたファイルを作成します。

>### **❗️注意**
>更新ボタンをクリックして、新しく作成されたディレクトリーとファイルをすべて表示してください。

```
---
- name: use apache_vhost role playbook
  hosts: node2
  become: true
  roles:
    - apache_vhost
```
>### **❗️注意**
>ロールの使用に必要な操作は、`roles:` 宣言で `apache_vhost` の名前を指定して呼び出すだけです。追加のロールがあれば、リストに追加できます。

☑️ タスク 9 - Ansible Playbook の実行
===

*control* タブ内で、次のコマンドを実行します。

```
ansible-navigator run test_apache_role.yml
```

☑️ タスク 10 - 結果の確認
===

Ansible Playbook は、`node2` ホストに対してロールを実行します。`curl` コマンドを使用してロールが機能したことを確認し、コンテンツの `simple vhost index` を含む Web ページが正しく表示されるかどうかを確認します。


```
curl -s http://node2:8081
```
```
simple vhost index
```

お疲れさまでした。「初めての Playbook 作成」のトラックを完了しました。

次の課題に挑戦したり、もっと探索したりしてみてください。

✅ 次の課題
===
以下の `Check` ボタンを押してプレイグラウンドに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+roles&assignees=rlopez133)をクリックしてください。

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
