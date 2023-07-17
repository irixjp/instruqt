---
slug: execute-survey-job-template
id: ixeiwwxy7ic5
type: challenge
title: サーベイを使ったジョブテンプレートの実行
teaser: 基本演習4の課題3では Network-Banner ジョブテンプレートを実行します。
notes:
- type: text
  contents: |+
    # 課題3 - Network-Banner ジョブテンプレートを実行します

    この課題では、第1回と第2回で作成したNetwork-Bannerジョブを実行するためにautomation controllerを使用する手順を説明します。

    まだプロビジョニングが開始されていない場合は、右下の緑色の開始ボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックしてください。

- type: text
  contents: |-
    # ジョブの起動

    Job Template リストウィンドウ（Job Template をクリックすると全ての Job Template がリストアップされます）からジョブを起動できます。

    ジョブテンプレート一覧ウィンドウから直接起動するには、ロケット船のアイコンをクリックしてください:

    ![rocket ship](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_launch_template.png)
- type: text
  contents: |-
    # サーベイのプロンプト

    サーベイはユーザーへの質問を含むウォークスルーウィンドウを起動します:

    ![picture of survey](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey.png)

    これは、自動化ユーザーが、あなたがコントロールすることを許可する変数に対して特定のコントロールを持つためのガードレールを作成します。
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
この課題では、**Network-Banner**ジョブ・テンプレートを実行する。

Automation Controllerにログインします
===

ログアウトしている場合は、automation controller にログインし直します。
<br><br>
画面上部の `Automation controller WebUI` タブを選択します。

以下の認証情報でログインします:

username: `admin`<br>
password: `ansible123!`


ステップ1 - Network-Banner ジョブ テンプレートの実行
===

- 左のナビゲーションメニューのリソースの下にある **Templates** をクリックして、**Job Templates** に移動します。 <img src="https://github.com/IPvSean/pictures_for_github/blob/master/job_templates.png?raw=true" width="150px">
- **Network-Banner** を実行するには、ジョブの起動ボタンであるロケットボタンをクリックしてください:

   <img src="https://github.com/IPvSean/pictures_for_github/blob/master/launch_job.png?raw=true">

- ジョブはすぐにバナーとタイプを設定するようユーザーに入力促します。

- バナーメッセージを入力してください。

```
This router was configured by Ansible
```

- `motd` を選択

- next をクリックすると、サーベイが Ansible Playbook の追加バーとして入力をどのようにレンダリングしたかを確認できます。この例では、バナーテキストは `This router was configured by Ansible` と設定されています。

![picture of survey](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey.png)

- 青色の Launch ボタンをクリックして作業を開始します。

   ![blue launch button](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_launch.png)


ステップ2 - 確認
===

1. 画面トップの Terminalタブ を開く

2. Ciscoネットワークデバイスにログインし、バナーセットアップを確認します。

```bash
ssh cisco
```

## 学んだこと

以下の演習を完了しました！:

- Arista EOS、Cisco IOS、Juniper Junos を含む複数のネットワークオペレーティングシステム上でバナーを設定するためのジョブテンプレートの作成。
- `network_banner`変数と`banner_type`変数を入力するためのジョブテンプレート用セルフサービスアンケートの作成
- 何百ものネットワークデバイスとプラットフォームで同時に実行できるジョブテンプレートの実行

# 演習は終了です

下の緑色の `Check` ボタンをクリックすると、ジョブが正しく実行されたことを確認し、演習が終了します。
