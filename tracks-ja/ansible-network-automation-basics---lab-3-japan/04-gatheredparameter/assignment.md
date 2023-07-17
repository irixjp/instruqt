---
slug: gatheredparameter
id: xz9iovsmdrno
type: challenge
title: gathered パラメーターの使用
teaser: gathered パラメータをリソースモジュールで使用する方法を学ぶ。
notes:
- type: text
  contents: '![state gathered picture](https://github.com/IPvSean/pictures_for_github/blob/master/gathered_note.png?raw=true)'
- type: text
  contents: |-
    # state gathered の例

    ```
        - name: use SNMP resource module
          cisco.ios.snmp_server:
            state: gathered
          register: snmp_config
    ```

    `state: gathered` でコンフィグを読み込み（ネットワークデバイスに適用しているわけではない）、 レジスタを使ってモジュールからの出力を snmp_config という変数に保存している。
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
ステップ1 - gathered playbook を作成する
===

code-server タブで `gathered.yml` という名前の新しいplaybookを作成する。

(以下の入力指示のペインは全てを表示するためにドラッグする必要があるかもしれません)

```yaml
---
- name: retrieve SNMP config
  hosts: cisco
  gather_facts: false

  tasks:

    - name: use SNMP resource module
      cisco.ios.snmp_server:
        state: gathered
      register: snmp_config

    - name: copy snmp_config to file
      copy:
        content: "{{ snmp_config | to_nice_yaml }}"
        dest: "{{ playbook_dir }}/{{ inventory_hostname }}_snmp.yml"
```

最初のタスクは、`state: merged`が`gathered`に変更され、コンフィグを（ネットワークデバイスに適用するのではなく）読み込んでいるため設定項目が不要になり、レジスタを使ってモジュールからの出力を snmp_config という変数に保存している以外は同じです。

`| to_nice_yaml` はフィルタで、JSON 出力 (デフォルト) を YAML に変換する。

`playbook_dir` と `inventory_hostname` はマジック変数とも呼ばれる特別な変数です。`playbook_dir` は単にプレイブックを実行したディレクトリを意味し、`inventory_hostname` はインベントリ内のデバイスの名前です。つまり、ファイルは cisco デバイス用の `/home/rhel/cisco_snmp.yml` として保存される。

ステップ2 - gathered playbook を実行する
===

ターミナルタブで `ansible-navigator run` コマンドを実行します。

```
ansible-navigator run gathered.yml --mode stdout
```

以下のような出力となります:

![picture of output](https://github.com/IPvSean/pictures_for_github/blob/master/gathered_output.png?raw=true)

ステップ3 - ファイルの確認
===

Cisco デバイスから収集された情報が格納されたファイルを確認します。

ファイルは `~/cisco_snmp.yml` というデバイス名で保存されています。

# 振り返り

- リソースモジュールは、ネットワークデバイス構文に変換できる単純なデータ構造を持っています。この場合、SNMP ディクショナリは Cisco IOS-XE ネットワークデバイス構文に変換されます。
- リソースモジュールは**べき等**であり、デバイスの状態をチェックするように設定できます。
- リソースモジュールは双方向性で、特定のリソースのファクトを収集するだけでなく、コンフィグレーションを適用することもできます。リソース・モジュールを使用してネットワーク・デバイスを設定しない場合でも、リソースの状態をチェックすることには多くの価値があります。
- 双方向の動作により、ブラウンフィールド・ネットワーク（既存のネットワーク）は、実行中のコンフィグレーションを構造化データに素早く変換することができる。これによって、ネットワーク・エンジニアは、より迅速にオートメーションを稼動させ、迅速にオートメーションの勝利を得ることができる。
