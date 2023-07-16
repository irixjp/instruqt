---
slug: examine-ansible-playbook
id: 3po2fltoytew
type: challenge
title: Ansibleドキュメントの使用
teaser: この課題では、すでに作成されたAnsible Playbookを調べます。
notes:
- type: text
  contents: |
    # Network Facts

    扱うトピック:
    - Ansibleドキュメント
    - ネットワークデバイスのファクト
    - debug モジュール
- type: text
  contents: |
    # Ansible によるネットワーク自動化のドキュメント

    ![picture of documentation for network automation](https://github.com/IPvSean/pictures_for_github/blob/master/network_docs.png?raw=true)

    [red.ht/NetworkDocs](red.ht/NetworkDocs)

    Ansibleのネットワーク自動化は getting started guide に含まれています。
- type: text
  contents: |
    # Ansible ドキュメントへのアクセス

    最新のコマンドユーティリティansible-navigatorを使えば、特定のモジュールの詳細だけでなく、利用可能なすべてのモジュールにアクセスするきっかけを作ることができます。

    ```
    $ ansible-navigator doc -l -m stdout
    add_host
    amazon.aws.aws_az_facts
    amazon.aws.aws_caller_facts
    amazon.aws.aws_caller_info

    ```

    ansible-navigatorの正式な紹介と、次の演習でansible-navigatorを使ってどのようにプレイブックを実行方法はこの演習で触れます。
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

    ラボのセットアップが完了したら、このウィンドウの右下にある緑のスタートボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックします。
tabs:
- title: terminal
  type: terminal
  hostname: code-server
difficulty: basic
timelimit: 600
---
# ステップ1 - ドキュメントを使う

ターミナルタブで `ansible-navigator` インタラクティブモードに入る。

```bash
ansible-navigator
```

以下のように表示されます:
```
`:doc <plugin>`
 ```

この機能を利用するには、`:doc debug` と入力して `debug` モジュールのドキュメントを表示します:

```bash
:doc debug
```

`debug`モジュールのドキュメントが対話型ターミナルセッションに表示されるようになりました。 これは、[docs.ansible.com](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debug_module.html) にあるのと同じドキュメントを YAML で表現したものです。 例をモジュールのドキュメントから直接 Ansible Playbook にカット・アンド・ペーストできます。

ビルトインされていないモジュールを参照する場合、3つの重要なフィールドがあります:

```
namespace.collection.module
```

例:
```
cisco.ios.facts
```

用語の説明:
- **名前空間** - 例 **cisco** - 名前空間は複数のコレクションのグループ化です。 **cisco** 名前空間には、**ios**、**nxos**、および**iosxr**を含む複数のコレクションが含まれます。
- **コレクション** - 例 **ios** - コレクションは、Playbook、ロール、モジュール、およびプラグインを含むことができるAnsibleコンテンツの配布形式です。 **ios**コレクションには、Cisco IOS/IOS-XE用のすべてのモジュールが含まれています。
- **モジュール** - ファクトの例 - モジュールは、プレイブックタスクで使用できるコードの個別の単位です。例えば、**facts**モジュールは、指定されたシステムに関する構造化されたデータを返します。

**Esc**キーを押してメインメニューに戻る。 `cisco.ios.facts`モジュールで`:doc`コマンドを繰り返してみてください。


```bash
:doc cisco.ios.facts
```

このあとの演習でファクトモジュールを使用します。
