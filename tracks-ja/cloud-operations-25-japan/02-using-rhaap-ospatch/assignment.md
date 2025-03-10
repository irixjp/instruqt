---
slug: using-rhaap-ospatch
id: eopjw8tcufos
type: challenge
title: Ansible Automation Platform を用いたOSパッチ適用
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
- id: ogdpaqsbwyly
  title: Automation Controller
  type: service
  hostname: controller
  port: 443
- id: m9dy5kgb8t2x
  title: AWS console
  type: service
  hostname: cloud-client
  path: /
  port: 80
difficulty: ""
timelimit: 900
enhanced_loading: null
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

左のナビゲーションメニューの `Automation Execution` の下にある `テンプレート(Templates)` リンクをクリックします。

- 次に`+ テンプレートの作成(Create Template)`をクリックし、下にスクロールして`ジョブテンプレートの作成(Create job template)`をクリックする。
<img src="https://github.com/HichamMourad/awsops25/blob/master/images/create_templates.png?raw=true" style="width:600px;margin-left:0px" >

以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>名前(Name)</td><td>Linux Patching</td>
<tr><td>ジョブタイプ(Job Type)</td><td>Check</td>
<tr><td>インベントリー(Inventory)</td><td>AWS Inventory</td>
<tr><td>プロジェクト(Project)</td><td>AWS Demo Project</td>
<tr><td>実行環境(Execution Environment)</td><td>Default execution environment</td>
<tr><td>Playbook</td><td>playbooks/lab2-patching.yml</td>
<tr><td>認証情報(Credentials)</td><td>RHEL on AWS - SSH KEY</td>
</table>

`認証情報(Credentials)`については、`Select Credentials`ドロップダウンから`RHEL on AWS - SSH KEY`を選択します。

一番下までスクロールし、青い`ジョブテンプレートを作成(Create Job Template)`ボタンをクリックしてジョブテンプレートを保存します。

このジョブテンプレートにサーベイを作成するには、`Survey` メニューオプションをクリックします。
青い `+ Create Survey Questions` ボタンをクリックします。
サーベイフォームに以下のフィールドを入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Question</td><td>Enter the Linux Host you want to patch</td>
<tr><td>Answer variable name</td><td>HOSTS</td>
<tr><td>Answer type</td><td>Multiple Choice (single select)</td>
<tr><td>Required</td><td>☑️</td>
<tr><td>Multiple Choice Options</td><td>rhel1</td>
</table>

`rhel1`の隣にある`Default option`ラジオボタンをクリックする。

一番下までスクロールして ` Create survey question` をクリックする。

Survey Disabled のダイヤルをオンにして、Surveyを有効にします。 するとテキストが`Survey Enabled`に変わります。
<img src="https://github.com/HichamMourad/awsops25/blob/master/images/survey_toggle_short.png?raw=true" style="width:600px;margin-left:0px" >

右上の`テンプレートの起動(Launch template)`ボタンをクリックすると、ジョブが起動します。

Surveyの質問に答えるように促されます。 すでに `rhel1` がデフォルト値になっていますので、`Next` をクリックしてジョブテンプレートの詳細を確認し、`Finish` をクリックします。

ジョブテンプレートの実行結果を見てください。 ジョブタイプを `Check` に設定したことを思い出してください。 見てわかるように、ジョブの出力は Linux Patching レポートを指しています。これについては次のタスクで説明します！


☑️ タスク2 - パッチ自動化ジョブからのレポート出力の表示
===

`Linux Patch` ジョブの出力はパッチレポートへの URL を提供します。

URLは次のようになります: `http://<ip-address>/reports/linux.html` と `http://<ip-addres>/reports/linuxpatch.html`

- これらのURLをそれぞれコピーして、新しいブラウザウィンドウに貼り付けて表示します。`linuxpatch.html`レポートには、インストールされる全てのパッチ更新と削除される全てのパッチのリストが表示されることに気づきましたか？

このチャレンジでは、Linuxのパッチ適用を実行しましたが、Ansible Automation Platformを使用して、Windowsのパッチ適用を実行することもできることに注目してください。

完了したら、`次の課題に進んでください`。`Next`をクリックします。


✅ 次の課題
===

この課題を完了したら、下の`Next`ボタンをクリックして、次の課題に進みます。
