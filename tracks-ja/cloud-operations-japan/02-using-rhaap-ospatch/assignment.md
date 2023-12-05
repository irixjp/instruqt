---
slug: using-rhaap-ospatch
id: ekcjcjczid89
type: challenge
title: Ansible Automation Platformを使って、OSにPatchを適用する
teaser: Ansible Automation Platformを使って、OSにPatchを適用します。
notes:
- type: text
  contents: |-
    # 課題の概要

    この課題では、AWS上で実行されている、Red Hat Enterprise Linux 仮想マシンに対して自動化を実行します。

    さらに <a target="_blank" href="https://docs.ansible.com/automation-controller/latest/html/userguide/job_templates.html#surveys">Survey</a> という機能も使います。  Surveyは、‘Prompt for Extra Variables’と同様に、Playbookに追加の変数を設定しますが、よりユーザーフレンドリーな質問に対する回答形式で行われます。

    ![survey_example.png](../assets/survey_example.png)
- type: text
  contents: |-
    # では始めましょう

    課題の説明はこれで終了です！

    ラボ環境のセットアップが完了したら、このウインドウの右下隅にある緑色のStartボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックしてください。
tabs:
- title: Automation Controller
  type: service
  hostname: controller
  port: 443
- title: AWS console
  type: service
  hostname: cloud-client
  path: /
  port: 80
- title: Automation Controller Terminal
  type: terminal
  hostname: controller
difficulty: basic
timelimit: 900
---
👋 課題の概要
===
## あなたの課題
###  想定時間: *15分*<p>

> AWSでEC2インスタンスのOSパッチ適用を実行するためのジョブテンプレートを作成します。この例では、Red Hat Enterprise Linux サーバーにパッチを適用します。また、レポートを生成し、サーバーインスタンス上で表示します。


☑️ タスク1 - Linuxホストにパッチを適用するジョブテンプレートの作成と実行
===

`Ansible Automation Controller`にログインします。
- ラボ上部の`Automation Controller`タブをクリックします。ラボツールバーには、複数のタブが存在します。

次の資格情報でログインします: <br>
*Login credentials:*<p>
`User:  admin` <p>
`Password:  ansible123!` <p>

---

ラボ上部の`Automation Controller`タブをクリックして、左のナビゲーションメニューの`Resources`グループ下の`Templates`をクリックします。

さらに、青色の`Add`ボタンをクリックし、`Add job template`を選択します。

以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Name</td><td>Linux Patching</td>
<tr><td>Job Type</td><td>Check</td>
<tr><td>Inventory</td><td>AWS Inventory</td>
<tr><td>Project</td><td>AWS Demo Project</td>
<tr><td>Execution Environment</td><td>Ansible Engine 2.9 execution environment</td>
<tr><td>Playbook</td><td>playbooks/lab2-patching.yml</td>
<tr><td>Credentials</td><td>RHEL on AWS - SSH KEY</td>
</table>

`Credentials`については、`Select Category`ドロップダウンから`Machine`を選択する必要があります。リストの中から`RHEL on AWS - SSH KEY`を選択します。

一番下までスクロールして、`Save`をクリックします。

`Survey`メニューオプションをクリックして、Surveyを作成します。
さらに、青色の`Add`ボタンをクリックします。
`Add Question`フォームに以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Question</td><td>Enter the Linux Host you want to patch</td>
<tr><td>Answer variable name</td><td>HOSTS</td>
<tr><td>Answer type</td><td>Text</td>
<tr><td>Default answer</td><td>rhel1</td>
</table>

一番下までスクロールして、`Save`をクリックします。

`Survey Disabled`ダイアルをONにしてSurveyを有効にします。これによりテキストが`Survey Enabled`に変わります。

そして、`Back to Templates`をクリックします。

`Linux Patching`ジョブテンプレートを選択して、`Launch`をクリックして起動するか、`Rocket Launcher` 🚀アイコンをクリックして、ジョブテンプレートを起動します。`Next`を選択して`Launch`を選択します。

ジョブテンプレートの実行の出力を確認します。`Run`には時間がかかるため、ジョブタイプを`Check`に設定したことを思い出してください。ご覧のとおり、ジョブ出力はLinuxパッチレポートを指しています。これについては次のタスクで詳しく説明します！


☑️ タスク2 - パッチ自動化ジョブからのレポート出力の表示
===

`Linux Patch`ジョブからの出力は、パッチレポートへのいくつかのURLを提供します。

URLは次のようになります: `http://<ip-address>/reports/linux.html` と `http://<ip-addres>/reports/linuxpatch.html`

- これらのURLをそれぞれコピーして、新しいブラウザウィンドウに貼り付けて表示します。`linuxpatch.html`レポートには、インストールされる全てのパッチ更新と削除される全てのパッチのリストが表示されることに気づきましたか？

このチャレンジでは、Linuxのパッチ適用を実行しましたが、Ansible Automation Platformを使用して、Windowsのパッチ適用を実行することもできることに注意してください。

完了したら、`次の課題に進んでください`。`Next`をクリックします。


✅ 次の課題
===

この課題を完了したら、下の`Next`ボタンをクリックして、次の課題に進みます。