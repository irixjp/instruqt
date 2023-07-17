---
slug: examine-ansible-playbook
id: lxh8kxvs2nev
type: challenge
title: SNMP設定の確認
teaser: この課題では、Cisco IOSルーターの既存のコンフィグレーションを検証する。
notes:
- type: text
  contents: |-
    # モジュール

    モジュールはAnsibleで実際の作業を行うもので、各プレイブックタスクで実行されるものです。

    - 一般的にPythonで記述されます。
    - モジュールは冪等である
    - モジュールはパラメータという形でユーザーの入力を受ける

    ![picture of task](https://github.com/IPvSean/pictures_for_github/blob/master/resource_module.png?raw=true)
- type: text
  contents: |+
    # ネットワークモジュール

    ネットワーク・オートメーション用のAnsibleモジュールは、通常、ベンダーのOSの後にモジュール名を付けて参照する。

    - namespace.collection.`facts`
    - namespace.collection.`command`
    - namespace.collection.`config`
    - namespace.collection.`resource`

    ネットワークベンダーごとの例:

    * Arista EOS = `arista.eos`
    * Cisco IOS/IOS-XE = `cisco.ios`
    * Cisco NX-OS = `cisco.nxos`
    * Cisco IOS-XR = `cisco.iosxr`
    * F5 BIG-IP = `f5networks.f5_bigip_bigip`
    * Juniper Junos = `junipsnetworks.junos`
    * VyOS = `vyos.vyos`

- type: image
  url: https://github.com/IPvSean/pictures_for_github/blob/master/resrouce_modules_slide.png?raw=true
- type: image
  url: https://github.com/IPvSean/pictures_for_github/blob/master/resrouce_modules_slide2.png?raw=true
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
# ステップ 1 - SNMP設定の確認

Cisco IOSルーターにログインし、現在のSNMP設定を確認する。

* コントロールノードのターミナルから、`ssh cisco`と入力します。

```bash
ssh cisco
```

コマンド`show snmp`を使ってSNMPの設定を調べる（SNMPはエージェントが利用できないと表示されるはずである）:

```
show snmp
```

以下のような出力が表示されます:

```bash
cisco# show snmp
%SNMP agent not enabled
```

Cisco デバイスの SNMP の実行コンフィギュレーションを調べるには、`show run | s snmp` を使います。このコマンドを実行しても、実行中のSNMPコンフィギュレーションはないので、出力はありません。

```
show run | s snmp
```

以下のような出力が表示されます:

```bash
cisco#sh run | s snmp
cisco#
```
ルータCLIを終了して、課題を完了します。

```
exit
```
