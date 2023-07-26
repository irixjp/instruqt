---
slug: execute-workflow-template
id: lgfv0ibqoy95
type: challenge
title: ワークフローの実行
teaser: ワークフローの動作を確認してみましょう
notes:
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
🔐 ログイン情報
===
Automation controller にログインするには、画面上部の `Automation controller WebUI` タブを選択します。

認証情報は以下になります:

>**Controller username**:
> ```yaml
>admin
>```
>**Controller password**:
>```yaml
>ansible123!
>```

ステップ1：ワークフローの実行
===
`Workshop Workflow` を実行します。テンプレートの画面から `Workshop Workflow` をクリックして、詳細画面を表示してください。


1. 起動ボタンをクリック

    ![launch workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step7_launch.png)

2. **Workshop Workflow** の実行を確認

    ![workflow job launched](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step7_final.png)

   ワークフロー・ジョブ中はいつでも、ノードをクリックして個々のジョブ・テンプレートを選択し、ステータスを確認することができます。

## 学んだこと

* バックアップを作成するワークフローテンプレートを作成し、全ネットワークノードのユーザーとバナーの作成を試みる。
* いずれかのジョブテンプレートが失敗した場合、指定されたバックアップにリストアします。
* ワークフローテンプレートを起動し、**Workflow Visualizer**を探索した。

## 完了

本演習は終了となります。
