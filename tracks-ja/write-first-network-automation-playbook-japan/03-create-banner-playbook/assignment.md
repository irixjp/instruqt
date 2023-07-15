---
slug: create-banner-playbook
id: 1zjqyukagmqf
type: challenge
title: ディレクトリ構造とAnsible Playbookの作成
teaser: 最初の設定プレイブックを作成する
tabs:
- title: VScode editor
  type: service
  hostname: code-server
  path: /editor/?folder=vscode-remote%3A%2F%2F%2fhome%2Frhel
  port: 80
- title: ansible-controller
  type: terminal
  hostname: code-server
difficulty: basic
timelimit: 600
---
👋 はじめに
===
#### 所要時間の目安 *3分*<p>
さまざまな目的に使用できる複数のモジュールがあります。参考として、 [利用可能なCisco IOSおよびCisco IOSXEモジュール](https://docs.ansible.com/ansible/latest/collections/cisco/ios/index.html#plugins-in-cisco-ios) のリストをここで確認できます。

この課題では、シスコ・ルーターにバナーを設定するプレイブックを書きます。そのために、`cisco.ios.ios_banner` [モジュール](https://docs.ansible.com/ansible/latest/collections/cisco/ios/ios_banner_module.html) を使用します:

ステップ1 - Playを作る
===

Ansible Playbookは[YAMLファイル](https://yaml.org/)です。YAMLは構造化されたエンコーディングフォーマットで、人間が読むこともできます。最初のプレイブックを作成するには、次のステップに従います:

- VScode editor タブをクリック

- Visual Studio コードで新規ファイルを作成します。トップ・ナビゲーション・バーの**File**をクリックし、**New File**をクリックします。

- 簡単にするために、プレイブックの名前を `banner.yml` とします。

- `banner.yml` に以下のプレイ定義を入力する:

```yaml
---
- name: Setup management Cisco IOSXE router config
  hosts: routers
  gather_facts: no

  tasks:

    - name: Add banner IOSXE
      cisco.ios.ios_banner:
        text: "First banner with Ansible"
        banner: "login"
        state: present
```

ステップ2 - Ansible Playbook の内容を確認
===

まず、最初の4行です:

```
---
- name: Setup management Cisco IOSXE router config
  hosts: routers
  gather_facts: no
```

* --- これはプレイブックを記述するYAMLファイルであることを示します。
* name: はこのプレイブックが何をするかの説明です。
* hosts: ルーターはこのプレイブックをシスコ・ルーターでのみ実行する。`routers` はグループ名である。
* gather_facts: false を指定すると、このプレイブックのファクト収集が無効になる。

2つ目のパートでは、cisco.ios_bannerモジュールを使うタスクが1つある。

```yaml
  tasks:

  - name: Add banner IOSXE
     cisco.ios.ios_banner:
      text: "First banner with Ansible"
      banner: "login"
	    state: present
```

以下のことに注意します:
* タスクに名前が付けられ、タスクのモジュール（`cisco.ios.ios_banner`）が参照される。
* モジュールのパラメータが追加される：
  * `text`: バナーに設定するテキストを定義する。
  * `banner`: 設定したいバナーのタイプを定義する: motd、login、exec、incoming、slip-ppp
	* `state`: 現在のデバイスのアクティブなコンフィグに存在するかどうかを指定します。デフォルトは "present "です。

	[cisco.ios.ios\_banner パラメータ](https://docs.ansible.com/ansible/latest/collections/cisco/ios/ios_banner_module.html#parameters) の完全なリストはここにあります。

ステップ3 - プレイブックを保存する
===

通常、Playbookは自動化保存されています。これで次の課題に進む準備ができました。


✅ 次の挑戦
===
タスクを完了したら、下の `Check` ボタンを押して次のチャレンジに進んでください。

🐛 問題が発生しましたか？
====

問題が発生した場合、または何かおかしいと気づいた場合は [open an issue](https://github.com/ansible/instruqt/issues/new?labels=network-automation-playbook&title=Issue+with+Writing+First+Network+Playbook+create-banner-playbook&assignees=dafmendo) を開いてください。


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

