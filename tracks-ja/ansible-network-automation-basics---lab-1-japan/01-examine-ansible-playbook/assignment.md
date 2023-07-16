---
slug: examine-ansible-playbook
id: bgakrcxr0mrj
type: challenge
title: 初めてのNetwork Ansible Playbook
teaser: この課題では、すでに作成されたAnsible Playbookを調べます。
notes:
- type: text
  contents: |-
    # Ansible ネットワークオートメーションの基本

    この実習の目的は、Ansible Automation を使用して Cisco CSR ルータの設定を更新することです。この実習では、Ansible Playbook は作成せず、提供されている既存のものを使用します。

    この演習では、以下を取り上げます:

     - 既存のAnsible Playbookの検証
     - ansible-navigator コマンドを使用して、コマンドラインで Ansible Playbook を実行する。
     - check モード (`--check` パラメータ)
     - verboseモード（--verbose`または-vパラメータ）
- type: text
  contents: |-
    # Ansible Playbookを構成するものは何か？

    <img src="https://github.com/IPvSean/pictures_for_github/blob/master/what_makes_up_playbook.png?raw=true">
- type: text
  contents: |
    # Ansible Plays

    何を自動化するか?

    ```
    - name: configure network devices
      hosts: network
      become: yes
    ```

    **これはなに？**

    - *タスクグループの最上位仕様*

      どのホストで実行されるかを指示し、事実の収集や権限レベルなどの動作を制御する。

    - *プレイブックのビルディングブロック*

      Ansibleプレイブック内に複数のプレイを存在させることができる
- type: text
  contents: |
    # Ansible モジュール

    *ツールキットの中の "ツール"*

    ```
        - name: ensure that the desired snmp strings are present
          cisco.ios.config:
            commands:
              - snmp-server community ansible-public RO
              - snmp-server community ansible-private RW
    ```

    **これはなに？**

    内部ロジックを持つパラメータ化されたコンポーネント。
    モジュールは、Ansibleでの仕事を「実行」します。

    **言語**

    通常はPython、Windowsセットアップの場合はPowershell。しかし、言語は問わない。
- type: text
  contents: |
    # Ansible プラグイン

    **これはなに？**
    プラグインは補強するコードの断片である。
    Ansibleのコア機能。Ansibleはプラグイン・アーキテクチャを採用し、豊富で柔軟、かつ拡張可能な機能セットを実現している。

    {{ some_variable | `to_nice_json` }}<br>
    {{ some_variable | `to_nice_yaml` }}
- type: text
  contents: |
    # Ansible インベントリー

    **これはなに？**

    自動化が実行されるインフラストラクチャのシステムのリスト

    ```
    [web]
    webserver1.example.com
    webserver2.example.com

    [db]
    dbserver1.example.com

    [switches]
    leaf01.internal.com
    leaf02.internal.com
    ```
- type: text
  contents: |
    # Ansible ロール

    ```
    - name: install and start apache
      hosts: network
      roles:
        - network.toolkit.backup
    ```

    **これはなに？**

    自動化のタスクと変数を再利用可能な構造でグループ化する。ロールを一度書いて、同じような課題を目の前にしている人たちと共有しよう。
- type: text
  contents: |
    # Ansible Content Collections

    *簡素化された一貫性のあるコンテンツ配信*

    **これはなに？**

    コレクションは、以下のようなオートメーション・コンテンツを含むディレクトリ構造である:
    - Modules
    - Playbooks
    - Roles
    - Plugins
    - Docs
    - Tests
- type: text
  contents: |-
    # さあはじめよう

    以上で演習のブリーフィングは終了です

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
ステップ1 - Ansible Playbookを調べる
===

code-serverタブで`playbook.yml`を開く。

Ansible Playbookの構成要素については、次の演習で詳しく説明します。今は、このPlaybookが2つのCisco IOS-XEコマンドを実行することがわかれば十分です:

```
snmp-server community ansible-public RO
snmp-server community ansible-private RW
```

ステップ2 - Ansible Playbookを実行する
===
ターミナルタブを開き、以下のコマンドを実行する:

```
ansible-navigator run playbook.yml --mode stdout
```


- `--mode stdout` - デフォルトでは、ansible-navigatorは対話モードで実行されます。デフォルトの動作は、ansible-navigator.yml設定ファイルを変更することで変更できます。playbookが長くなり、複数のホストが関与するようになると、インタラクティブモードはリアルタイムでデータを "ズームイン "し、フィルタリングし、様々なAnsibleコンポーネント間をナビゲートできるようになります。このタスクは1つのホストで1つのタスクを実行するだけなので、標準出力で十分です。

ステップ3 - ルーターの設定を確認する
===

ciscoデバイスにログインし、show runコマンドを実行してコンフィグレーションを確認する:
```
ssh cisco
show running | i snmp
```
出力は以下のようになるはずです:
```
snmp-server community ansible-public RO
snmp-server community ansible-private RW
```
