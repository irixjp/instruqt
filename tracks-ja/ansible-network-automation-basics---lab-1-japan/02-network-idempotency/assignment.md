---
slug: network-idempotency
id: lqbwdi6s8w4l
type: challenge
title: 冪等性の確認
teaser: 良いプレイブックとは冪等性があるプレイブックです
notes:
- type: text
  contents: |
    # モジュールについての深掘り

    モジュールはAnsibleで実際の作業を行うもので、各プレイブックタスクで実行されるものです。

    - 一般的にPythonで記述されます。
    - モジュールは冪等である
    - モジュールはパラメータという形でユーザーの入力を受ける
- type: text
  contents: |
    # ネットワークモジュール

    ネットワーク・オートメーション用のAnsibleモジュールは、通常、ベンダーのOSの後にモジュール名を付けて参照する。

    - `namespace.collection.facts`
    - `namespace.collection.command`
    - `namespace.collection.config`
    - `namespace.collection.resource`

    例:
    - Arista EOS = `arista.eos.`
    - Cisco IOS/IOS-XE = `cisco.ios.`
    - Juniper Junos = `junipsnetworks.junos.`
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

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
ステップ1 - 冪等性の検証
===

`cisco.ios.config` モジュールは冪等です。つまり、コンフィギュレーションの変更がデバイスにプッシュされるのは、そのコンフィギュレーションがエンドホストに存在しない場合だけです。

<table>
  <tr>
    <th>Ansible Automationの用語に困ったら</th>
  </tr>
  <tr>
    <td>冪等性のような用語については、<a href="https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html">用語集</a> を確認してください</td>
  </tr>
</table>

冪等性の概念を検証するために、プレイブックを再実行する:

```
ansible-navigator run playbook.yml --mode stdout
```

<table>
  <tr>
    <th>NOTE:</th>
  </tr>
  <tr>
    <td><b>PLAY RECAP</b> の <b>changed parameter</b> が 0 であることを確認する。
</td>
  </tr>
</table>

Ansible Playbookを複数回再実行すると、**ok=1**、**change=0**で、まったく同じ出力になります。

他のオペレータまたはプロセスがrtr1上の既存のコンフィグレーションを削除または変更しない限り、このAnsible Playbookは、コンフィグレーションがすでに存在し、ネットワークデバイス上で正しくコンフィグレーションされていることを示すok=1を報告し続けます。

ステップ2 - Ansible Playbookを変更する
===

タスクを更新して、ansible-testというSNMP ROコミュニティ文字列を1つ追加します。

```
snmp-server community ansible-test RO
```

code-serverを使って`playbook.yml`ファイルを開き、コマンドを追加する:

変更したplaybook.ymlは必ず保存してください。

ステップ3 - チェックモードを使用する
===

ただし今回は、playbookを実行して変更をデバイスにプッシュするのではなく、-checkフラグと-v（verboseモード）フラグを組み合わせて実行する:

```
ansible-navigator run playbook.yml --mode stdout --check -v
```

`check mode` と `--verbose` フラグを組み合わせると、実際に変更をプッシュすることなく、エンドデバイスにデプロイされる正確な変更が表示されます。これは、プッシュする前にデバイスにプッシュしようとしている変更を検証するための素晴らしいテクニックです。

ステップ4 - コンフィグが存在しないことを確認する
===

Ansible Playbook が ansible-test コミュニティを適用していないことを確認する。cisco`にログインし、Cisco IOS-XEデバイスの実行中のコンフィグレーションを確認する。

```
ssh cisco
show run | i snmp
```

出力は以下のようになるはずです:
```
snmp-server community ansible-public RO
snmp-server community ansible-private RW
```

ステップ5 - Ansible Playbookを再実行する
===

最後に、-vまたは-checkフラグを付けずにこのプレイブックを再度実行し、変更をプッシュする。

```
ansible-navigator run playbook.yml --mode stdout
```

ステップ6 - コンフィグが存在することを確認する
===

```
ssh cisco
```

以下のコマンドを実行してください。

```
sh run | i snmp
```

以下のような出力になるはずです:

```
snmp-server community ansible-public RO
snmp-server community ansible-private RW
snmp-server community ansible-test RO
```


学んだこと
===

- config (例 `cisco.ios.config`)モジュールはidempotent、つまりステートフルです。
- **check mode** は、Ansible Playbook がリモート・システムに変更を加えないことを保証する。
- **verboseモード**では、どのコマンドが適用されるかを含め、ターミナルウィンドウへの出力をより多く見ることができる。
- この Ansible Playbook は、設定を実施するために **Automation controller** でスケジュールすることができる。例えば、これは特定のネットワークに対して Ansible Playbook を1日1回実行することを意味します。checkモード**と組み合わせると、ネットワーク上で構成が欠落していたり変更されていたりした場合に、読み取り専用のAnsible Playbookを実行してレポートすることができます。

# 完了
