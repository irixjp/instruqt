---
slug: controller
id: 9ju5wohonuee
type: challenge
title: Automation controller の操作方法
teaser: |
  Automation Controllerで、AWS EC2インスタンスの動的インベントリーを表示し、環境内のEC2インスタンスの情報を取得して出力するPlaybookを実行するジョブテンプレートを作成します。
notes:
- type: text
  contents: |-
    ラボ環境の作成がまだ開始されていない場合は、`右下隅`にある緑色のStartボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="right"> をクリックしてください。

    ラボの説明を開始するには、右側の白い`>`をクリックしてください。-->
- type: text
  contents: |
    # Automation controller

    `Automation controller` はAnsible Automation Platformのコントロールプレーンに相当します。

    <center><img src="https://github.com/IPvSean/pictures_for_github/blob/master/automation_controller.png?raw=true" width=600px%></center>

    Automation Controllerは、自動化の展開、開始、委任、監査の方法を標準化し、無秩序な環境の拡大や差異の発生を抑え、企業が自動化を自信を持って進めるように支援します。インベントリーの管理、
    ワークフローの起動とスケジュール、変更の追跡、レポートへの統合など、全てを一元化されたユーザーインターフェースとRESTful APIから行うことができます。
- type: text
  contents: |+
    # インベントリー(Inventories)

    インベントリーは、Ansible インベントリ ファイルと同様に、ジョブを起動できるホストのコレクションです。 インベントリーはグループに分割されており、これらのグループには実際のホストが含まれます。
    グループは、Automation Controllerにホスト名を入力することによって手動で取得することも、またはサポートされているクラウドプロバイダーから取得することもできます。

    # インベントリープラグイン

    様々な事前構築済みのインベントリープラグインが用意されています。

    * Amazon Web Services EC2
    * Google Compute Engine
    * Microsoft Azure Resource Manager
    * VMware vSphere and vCenter

- type: text
  contents: |-
    # ラボ環境の概要

    ラボ環境の概要図です。
    <center>
    <img src="https://github.com/IPvSean/pictures_for_github/blob/master/aws-diagram.png?raw=true" width="600px"></center>

    1つの`Automation Controller`ノードと、2つの`Red Hat Enterprise Linux`ノードが、Elastic Compute Cloud (EC2) ノードとして、Amazon Web Services(AWS)上で稼働しています。
- type: text
  contents: |-
    # ワークフロー(Workflows)

    ワークフローを使用して、インベントリー、Playbook、権限、の共有に関わらず、一連の異なるジョブテンプレート(またはワークフローテンプレート)を構成できます。

    <img src="https://github.com/HichamMourad/awsops25/blob/master/images/wf1.png?raw=true" style="width:900px;margin-left:0px" >

    詳細はこちらをご参照ください。 <a target="_new" href="https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/using_automation_execution/controller-workflow-job-templates#controller-workflow-job-templates">workflows in the documentation</a>
- type: text
  contents: |-
    # 始めましょう

    ラボの説明はこれで終了です！

    ラボ環境のセットアップが完了したら、このウインドウの右下隅にある緑色のStartボタン </br> <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left">
    をクリックしてください。
tabs:
- id: 9z2unymqiyzz
  title: Automation Controller
  type: service
  hostname: controller
  port: 443
- id: 1yzhjn2a0zcb
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
#### 想定時間: *15分*<p>
* `ハイブリッドクラウド・オートメーション: AWS クラウドオペレーション ラボ`へようこそ！次の課題とタスクでは、Day2のクラウド運用を理解し、クラウド運用のトピックに関するいくつかの一般的なユースケースを自動化する方法を説明します。

* この最初の課題では、このラボ用に既に構成されている動的インベントリーについて学習します。このインベントリーが表示され、インベントリーリソース上に配置されたタグを通じて、インベントリーについて詳しく知ることができます。

☑️ タスク1 - 資格情報(Credentials)の理解
===

`Ansible Automation Controller`にログインします。
- ラボ上部の`Automation Controller`タブをクリックします。ツールバーには、複数のタブが存在します。

次の資格情報でログインします: <br>
*Login credentials:*<p>
`User:  admin` <p>
`Password:  ansible123!` <p>
---

資格情報は、マシンに対してジョブを起動したり、インベントリーソースと同期したり、バージョン管理システムからプロジェクトコンテンツをインポートしたりする際の認証に利用されます。このラボでは、2つの異なる資格情報があります:

* `RHEL on AWS - SSH KEY` - AWS上で実行されている、2つのRed Hat Enterprise LinuxホストのSSHキー。
* `AWS_Credential` - AWSクラウド上でアクションを実行するためのAWS認証情報。例えば、VPCやその他のAWSリソースの作成、インスタンスのシャットダウン、OSやアプリケーションのインストールと構成など。 AWSで実行する必要があるほぼ全ての作業で必要。

ラボの上部にある `Automtion Controller` タブをクリックします。左側のナビゲーションメニューの `Automation Execution` -> `Infrastructure` ->` Credentials` の下にある `Credentials` リンクをクリックします。 上記の 2 つの設定済み認証情報を確認します。

`注意` キーは暗号化されるため、Automation Controllerにキーが配置されると、管理者であってもキーを参照することはできなくなります。


☑️ タスク2 - AWSインベントリー
===

ラボの上部にある `Automation Controller` タブをクリックします。左ナビゲーションメニューの `Automation Execution` -> `Infrastructure` ->` Inventories` の下にある `Inventories` リンクをクリックします。
`AWS Inventory`という作成済みのインベントリがあることを確認してください。

このインベントリをクリックして、`Sources` タブを選択してください。
そこから `AWS Source` を選択し、`Launch inventory update` ボタンをクリックします。 これにより、AWS上のホストリストが同期/更新されます。

Statusに`Success`と表示されるまで待ち、`Hosts`タブをクリックしてEC2インスタンスを表示します（Hostsタブを表示するには、`Back to Inventory Sources` をクリックする場合もあります）
ここで、事前にデプロイされたインスタンスのリストが確認できます。


☑️ タスク3 - EC2インスタンスの情報を取得して表示するジョブテンプレートの作成
===

ラボの上部にある `Automation Controller` タブをクリックします。

左のナビゲーションメニューの `Automation Execution` の下にある `Templates` リンクをクリックします。

- 次に`+ Create Template`をクリックし、下にスクロールして`Create job template`をクリックしてください。
<img src="https://github.com/HichamMourad/awsops25/blob/master/images/create_templates.png?raw=true" style="width:600px;margin-left:0px" >

以下の項目を入力してください:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Name</td><td>Retrieve EC2 information</td>
<tr><td>Inventory</td><td>AWS Inventory</td>
<tr><td>Project</td><td>AWS Demo Project</td>
<tr><td>Playbook</td><td>playbooks/lab2-ec2-info.yml</td>
<tr><td>Credentials</td><td>AWS_Credential</td>
</table>

`Credentials` については、`Select Category` ドロップダウンから `Amazon Web Services` を選択すると、`AWS_credential` が選択リストに表示されます。

入力が完了したら一番下までスクロールし、青い `Create Job Template` ボタンをクリックしてジョブテンプレートを保存します。

`Retrieve EC2 information`ジョブテンプレートを選択して、`Launch`をクリックして起動するか、`Rocket Launcher` 🚀アイコンをクリックして、ジョブテンプレートを起動します。

`ジョブテンプレートの出力を観察します。`

非常に動的な環境では、AWSインベントリー (EC2 インスタンス) が頻繁に変更される可能性があります。従って、ジョブテンプレートを実行する前にインベントリの同期をトリガーすることが重要です。`これについては、タスク4で扱いましょう。`

☑️ タスク4 - インベントリーの同期をトリガーするワークフローテンプレートの作成と、ジョブテンプレートの実行
===

ラボの上部にある`Automation Controller`タブをクリックします。

左のナビゲーションメニューの `Automation Execution` の下にある `Templates` リンクをクリックします。

- 次に`+ Create Template`をクリックし、下にスクロールして`Create workflow job template`をクリックします。
<img src="https://github.com/HichamMourad/awsops25/blob/master/images/create_templates.png?raw=true" style="width:600px;margin-left:0px" >

以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Name</td><td>WORKFLOW - Retrieve EC2 information</td>
<tr><td>Inventory</td><td>AWS Inventory</td>
</table>

一番下までスクロールして `Create workflow job template` ボタンをクリックします。

ワークフローのビジュアルデザイナーが開きます。 `Add step` ボタンをクリックします。
`Add step` ダイアログで、`Node Type` ドロップダウンを展開し、`Inventory Source Sync` を選択し、`Inventory source` ドロップダウンから `AWS Source` を選択し`Next` をクリックします。最後に`Finish`をクリックしてこのステップを保存します。

この時点で、AWS Inventory の同期をトリガーするワークフローの最初のノードができました。 `AWS Source` というタイトルのノードで `ellipsis (縦三点リーダー)` **︙** をクリックし、`+ Add step and link` を選択してワークフローに別のノードを追加します。

ここでは、`Node Type`は`Job Template`を選択します。 `Job template` ドロップダウンから、`Retrieve EC2 information` ジョブテンプレートをリストから選択してください。

`Status` ドロップダウンから、`Run on success` が選択されていることを確認する。 これにより、ワークフローの最初のノードが正常に完了するまで、このステップに進まない。 次に `Next` を選択し、次に `Finish` を選択してこのステップを保存します。

ワークフローデザイナーの左上にある `Save` をクリックし、ワークフローテンプレートを保存します。

左ナビゲーションメニューの `Automation Execution` の下にある `Templates` リンクに戻ります。ワークフローテンプレート `WORKFLOW - Retrieve EC2 information` を起動してください。 ジョブの詳細を見るには、各ワークフローノードを選択し、`Output`タブに移動してそのノードの実行の詳細を見ることができます。

ここまでに作成した`Workflow template`は、AWSのインベントリを最新のインベントリに更新した後で、更新されたEC2インスタンスの情報を取得するジョブテンプレートを実行します。

完了したら、`次の課題に進んでください`。`Next`をクリックします。

✅ 次の課題
===

この課題を完了したら、下の`Next`ボタンをクリックして、次の課題に進みます。
