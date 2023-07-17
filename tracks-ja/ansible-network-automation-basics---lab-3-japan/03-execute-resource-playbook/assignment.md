---
slug: execute-resource-playbook
id: oy2fpehzcflb
type: challenge
title: Ansible Playbookを実行する
teaser: リソースモジュールの動作を確認する
notes:
- type: text
  contents: '![picture of ansible-navigator](https://github.com/IPvSean/pictures_for_github/blob/master/ansible-navigator.png?raw=true)'
  url: https://docs.google.com/presentation/d/1F-nc9dKXemdD5FJXNQoaEZzp_eADTSDKpXLLu4jYapI/edit?usp=sharing
- type: text
  contents: '![2nd picture of ansible-navigator](https://github.com/IPvSean/pictures_for_github/blob/master/ansible-navigator-2.png?raw=true)'
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
- title: Terminal
  type: terminal
  hostname: code-server
difficulty: basic
timelimit: 600
---
ステップ 1
===

Terminal タブに切り替えて、Ansible Playbook を実行する準備をします。


ステップ2 - Ansible Playbookを実行する
===

`ansible-navigator run` を使ってplaybookを実行する。タスクは1つだけなので、-mode stdoutを使います。

```
ansible-navigator run resource.yml --mode stdout
```
以下のような出力となります:

![picture of playbook output](https://github.com/IPvSean/pictures_for_github/blob/master/playbook_output_lab_4.png?raw=true)

プレイブックを再実行して、[冪等性](https://en.wikipedia.org/wiki/Idempotence) を確認します。

```
ansible-navigator run resource.yml --mode stdout
```

以下のような出力となります:

![picture of playbook output](https://github.com/IPvSean/pictures_for_github/blob/master/playbook_output_lab_4_part2.png?raw=true)

出力を確認すると、プレイブックを最初に実行したときのステータスは ok=1 と changed=1 であった。これは、ciscoホスト上でSNMPコンフィグが設定されたためです。

プレイブックが2回目に実行されると、ok=1 change=0と出力されます。これはプレイブックの冪等性によるものです。つまり、2回目が実行されたとしても、コンフィグはすでに設定されており、playbookが変更する必要はない（changed=0）ためです。

ステップ3 - SNMP設定の確認
===

Cisco スイッチにログインし、現在の SNMP 設定を確認する。

コントロールノードのターミナルから、`ssh cisco` を実行する。

```
ssh cisco
```

SNMPの設定を調べるには、`show snmp`コマンドを使用:

```
show snmp
```

以下のような出力が得られます:

```
cisco#show snmp
Chassis: 99SDJQ9I6WK
Location: Durham
0 SNMP packets input
    0 Bad SNMP version errors
    0 Unknown community name
    0 Illegal operation for community name supplied
    0 Encoding errors
    0 Number of requested variables
    0 Number of altered variables
    0 Get-request PDUs
    0 Get-next PDUs
    0 Set-request PDUs
    0 Input queue packet drops (Maximum queue size 1000)
0 SNMP packets output
    0 Too big errors (Maximum packet size 500)
    0 No such name errors
    0 Bad values errors
    0 General errors
    0 Response PDUs
    0 Trap PDUs
Packets currently in SNMP process input queue: 0
SNMP global trap: disabled

SNMP logging: disabled
```

`show run | s snmp`を使用して、CiscoデバイスのSNMPの実行中の設定を調べます:

```
show run | s snmp
```

以下のような出力となるはずです:

```
cisco#show run | s snmp
snmp-server community Durham-community RW acl_uq
snmp-server community ChapelHill-community RW acl_uq
snmp-server packetsize 500
snmp-server location Durham
```

ご覧のように、リソースモジュールは提供されたコンフィグレーションでCisco IOS-XEネットワークデバイスをコンフィグレーションしました。SNMPコミュニティは全部で2つあります。

# 完了

課題３が終了しました！
