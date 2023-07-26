---
slug: ansible-resource-playbook
id: 9gvhavk8i66s
type: challenge
title: Ansible Playbookの作成
teaser: ファクトの収集から始めましょう
notes:
- type: image
  url: https://github.com/IPvSean/pictures_for_github/blob/master/config-to-code.png?raw=true
- type: text
  contents: |-
    # リソースモジュール

    Ansible ネットワークリソースモジュールは、さまざまなネットワークデバイスの管理方法を簡素化し、標準化します。ネットワークデバイスは、設定をネットワークサービスに適用されるセクション（インターフェースや VLAN など）に分割します。

    ネットワークリソースモジュールは、異なるネットワークデバイス間で一貫したエクスペリエンスを提供します。つまり、複数のベンダー間で同じエクスペリエンスを得ることができます。例えば、snmp_server モジュールは、以下のモジュールで同じように動作します:

    - arista.eos.snmp_server
    - cisco.ios.snmp_server
    - cisco.nxos.snmp_server
    - cisco.iosxr.snmp_server
    - junipernetworks.junos.snmp_server
- type: text
  contents: |-
    # なぜSNMPを例に挙げるのか?

    ネットワーク機器にSNMPを設定することは非常に一般的な作業であり、誤った設定は頭痛の種やモニタリングの問題を引き起こす可能性があります。SNMPコンフィギュレーションはまた、複数のネットワーク・スイッチ間で同一になる傾向があり、その結果、自動化のための完璧なユースケースとなります。

    この演習では以下を実施します:

    - Cisco IOSでSNMPを設定する
    - cisco.ios.snmp_serverモジュールを使用したAnsible Playbookの構築。
    - `state: merged` を理解する
    - `state: gathered` を理解する
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
ステップ1 - Play を作る
===

Ansible Playbookは[YAMLファイル](https://yaml.org/)です。YAMLは構造化されたエンコーディングフォーマットであり、（JSONフォーマットのサブセットとは異なり）非常に人間が読みやすいフォーマットです。

- code-server タブをクリックします

- Visual Studioのコードで新しいファイルを作成します。 **New File** をクリックします。

- プレイブックの名前を設定: `resource.yml`

- 以下のプレイ定義を `resource.yml` に入力します:

```yaml
---
- name: configure SNMP
  hosts: cisco
  gather_facts: false

  tasks:

    - name: use snmp resource module
      cisco.ios.snmp_server:
        state: merged
        config:
          location: 'Durham'
          packet_size: 500
          communities:
            - acl_v4: acl_uq
              name: Durham-community
              rw: true
            - acl_v4: acl_uq
              name: ChapelHill-community
              rw: true
```

ステップ2 - Ansible Playbookを調べる
===

最初の4行を確認します:

```
---
- name: configure SNMP
  hosts: cisco
  gather_facts: false
```

* `---` はプレイブックを記述するYAMLファイルであることを示します。
* `name` はこのプレイブックが何をするかの説明です。
* `hosts: cisco` はこのプレイブックをインベントリーの cisco という名前のオブジェクトに実行すること示します。今回のインベントリーは `~/hosts` に定義されており、`cisco` というホストが1台のみ登録さています。
* `gather_facts: false` は、このプレイブックのファクト収集を無効にします。デフォルトでは有効になっています。

残りパートでは、cisco.ios.snmp_server を使用するタスクを1つ用意します。

```yaml
  tasks:

  - name: use snmp resource module
    cisco.ios.snmp_server:
      state: merged
      config:
        location: 'Durham'
        packet_size: 500
        communities:
          - acl_v4: acl_uq
            name: Durham-community
            rw: true
          - acl_v4: acl_uq
            name: ChapelHill-community
            rw: true
```

- `name:` - Play と同じように、各タスクにはその特定のタスクの説明を持ちます。
- `state: merged` - これはリソースモジュールのデフォルトの動作です。これは単に、提供された設定がネットワークデバイス上に存在することを強制します。リソースモジュールには7つのパラメータがあります：
  - merged
  - replaced
  - overridden
  - deleted
  - rendered
  - gathered
  - parsed

この演習では、これらのステートパラメーターのうち2つだけを取り上げます。 他のステート・パラメータについては [exercise walkthrough here](https://aap2.demoredhat.com/exercises/ansible_network/supplemental/resource/) を確認するか、[documentation](https://docs.ansible.com/ansible/latest/network/user_guide/network_resource_modules.html) を参照してください。

- `config:` - これはSNMPコンフィギュレーションです。辞書のリストである。最も重要なことは、モジュールを cisco.ios.snmp\_server から junipernetworks.junos.snmp\_server に変更しても、同じように動作するということです。これにより、ネットワークエンジニアは、ベンダーの構文や実装ではなく、ネットワーク（SNMP設定など）に集中することができます。

ステップ 3 - プレイブックを保存する
===

次の演習のためにプレイブックを保存してください。

完了
===

課題２は終了です！
