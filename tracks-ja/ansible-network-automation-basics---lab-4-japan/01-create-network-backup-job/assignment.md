---
slug: create-network-backup-job
id: smqx9bsj9r2i
type: challenge
title: ネットワーク機器のバナーを設定するジョブテンプレートの作成
teaser: 基本演習4の課題1では Automation Controller でネットワークバナーを設定するジョブテンプレートの作成方法を学びます
notes:
- type: text
  contents: |
    # 演習 4 - Ansible Automation Platformのサーベイについて学ぶ

     Automation Controller の [Survey](https://docs.ansible.com/automation-controller/latest/html/userguide/job_templates.html#surveys) 機能の使い方を確認します。サーベイでは、'Prompt for Extra Variables'と同様に、プレイブックに追加の変数を設定しますが、ユーザーフレンドリーな質問と回答の方法で設定します。サーベイは、ユーザー入力の検証を可能にします。

    まだプロビジョニングが開始されていない場合は、右下の緑色の開始ボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックしてください。
- type: text
  contents: |+
    # サーベイ

    Ansible Controllerのサーベイは、ユーザがジョブの実行をカスタマイズできるシンプルな質問と回答のフォームです。Controllerのロールベースのアクセスコントロールと組み合わせることで、シンプルで簡単なセルフサービスを構築できます。

    サーベイのユースケースは数多くあります。例えば、高度なAnsibleの知識がなくても実行できる「プッシュ・トゥ・ステージ」ボタンを開発者に提供したい場合です。このタスクを起動すると、"どのタグをリリースすべきか？"といった質問への回答を求めることができます。

    多肢選択問題など、さまざまなタイプの質問を出題することが可能です。

- type: text
  contents: |-
    # 最初にジョブテンプレートを作成する

    ジョブテンプレートが作成され保存されると、トップメニューに **サーベイ** タブが表示されます。

    ![picture of where survey button is](https://github.com/IPvSean/pictures_for_github/blob/master/survey.png?raw=true)
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

    ラボのセットアップが完了したら、このウィンドウの右下にある緑のスタートボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックします。
tabs:
- title: Automation controller WebUI
  type: service
  hostname: controller
  port: 443
- title: Automation controller Terminal
  type: terminal
  hostname: controller
difficulty: basic
timelimit: 300
---
この演習では、 Automation controller で自動化ジョブを作成します。

Automation コントローラーにログインします
===
Automation controller にログインするには、画面上部の `Automation controller WebUI` タブを選択します。

以下の認証情報でログインする:

username: `admin`<br>
password: `ansible123!`

ステップ1 - 自動化ジョブの作成
===

- 左のナビゲーションメニューの Resources の下にある **Templates** をクリックして、**Job Templates** に移動します。<img src="https://github.com/IPvSean/pictures_for_github/blob/master/job_templates.png?raw=true" width="150px">
- 既に作成された **Job Templates** の一覧が表示されます。 ジョブテンプレートは Ansible playbook のコンテンツの再利用とチーム間のコラボレーションを促進します。
- 青い Add ボタンをクリックし、**Add job template** を選択します。
- 以下の値を入力します。

<table>
  <tr>
    <th>Name</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Name</td>
    <td><code>Network-Banner</code></td>
  </tr>
  <tr>
    <td>Job Type</td>
    <td><code>Run</code></td>
  </tr>
  <tr>
    <td>Inventory</td>
    <td><code>Network Inventory</code></td>
  </tr>
  <tr>
    <td>Project</td>
    <td><code>Network Toolkit</code></td>
  </tr>
  <tr>
    <td>Execution Environment</td>
    <td><code>Default execution environment</code></td>
  </tr>
  <tr>
    <td>Playbook</td>
    <td><code>playbooks/network_banner.yml</code></td>
  </tr>
  <tr>
    <td>Credential<br></td>
    <td><code>Network Credential</code></td>
  </tr>
</table>

- 青色の **Save** ボタンをクリックし、ジョブテンプレートを保存します。

ステップ2 - 検証
===

本演習のインストラクション右下の緑色の `Check` ボタンをクリックして、ジョブテンプレートが作成されたことを確認します。

