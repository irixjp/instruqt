---
slug: controller
id: brip4ft0ofjs
type: challenge
title: Automation Controllerの使い方を理解する
teaser: Automation Controllerで、AWS EC2インスタンスの動的インベントリーを表示し、環境内のEC2インスタンスの情報を取得して出力するPlaybookを実行するジョブテンプレートを作成します。
notes:
- type: text
  contents: |-
    ラボ環境の作成がまだ開始されていない場合は、`右下隅`にある緑色のStartボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="right"> をクリックしてください。

    ラボの説明を開始するには、右側の白い`>`をクリックしてください。-->
- type: text
  contents: |
    # Automation Controller

    `Automation Controller`(旧Ansible Tower)は、Ansible Automation Platformのコントロールプレーンに相当します。

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

    ![full_workflow_azure.png](../assets/full_workflow_azure.png)

    詳細はこちらを参照ください。 <a target="_new" href="https://docs.ansible.com/automation-controller/latest/html/userguide/workflows.html">Workflows in the documentation</a>
- type: text
  contents: |-
    # では始めましょう

    ラボの説明はこれで終了です！

    ラボ環境のセットアップが完了したら、このウインドウの右下隅にある緑色のStartボタン </br> <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left">
    をクリックしてください。
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
#### 想定時間: *15分*<p>
> `ハイブリッドクラウド・オートメーション: AWS クラウドオペレーション ラボ`へようこそ！次の課題とタスクでは、Day2のクラウド運用を理解し、クラウド運用のトピックに関するいくつかの一般的なユースケースを自動化する方法を説明します。

> この最初の課題では、このラボ用に既に構成されている動的インベントリーについて学習します。このインベントリーが表示され、インベントリーリソース上に配置されたタグを通じて、インベントリーについて詳しく知ることができます。

☑️ タスク1 - 資格情報(Credentials)の理解
===

`Ansible Automation Controller`にログインします。
- ラボ上部の`Automation Controller`タブをクリックします。ラボツールバーには、複数のタブが存在します。

次の資格情報でログインします: <br>
*Login credentials:*<p>
`User:  admin` <p>
`Password:  ansible123!` <p>
---

資格情報は、マシンに対してジョブを起動したり、インベントリーソースと同期したり、バージョン管理システムからプロジェクトコンテンツをインポートしたりする際の認証に利用されます。このラボでは、2つの異なる資格情報があります。

* `RHEL on AWS - SSH KEY` - AWS上で実行されている、2つのRed Hat Enterprise LinuxホストのSSHキー。
* `AWS_credential` - AWSクラウド上でアクションを実行するためのAWS認証情報。例えば、VPCやその他のAWSリソースの作成、インスタンスのシャットダウン、OSやアプリケーションのインストールと構成など。 AWSで実行する必要があるほぼ全ての作業で必要。

ウインドウ上部の`Automation Controller`タブで、`Resources`下の`Credentials`リンクをクリックして、事前に構成されている2つの資格情報を確認します。

`注意` キーは暗号化されるため、Automation Controllerにキーが配置されると、管理者であってもキーを参照することはできなくなります。


☑️ タスク2 - AWSインベントリー
===

ラボ上部の`Automation Controller`タブをクリックして、`Resources`下の`Inventories`リンクをクリックします。`AWS Inventory`という名前のインベントリーが作成されているはずです。このインベントリーをクリックし、`Sources`タブを選択します。`Sync All`アイコンをクリックします。これにより、AWS EC2ホストリストが同期、更新されます。

ステータスが`Successful`と表示されるまで待ち、`Hosts`タブをクリックしてEC2インスタンスを表示します。

☑️ タスク3 - EC2 インスタンスに関する情報の取得と、端末に表示するためのジョブテンプレートの作成
===

ラボ上部の`Automation Controller`タブをクリックして、左のナビゲーションメニューの`Resources`グループ下の`Templates`をクリックします。

さらに、青色の`Add`ボタンをクリックし、`Add job template`を選択します。

以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Name</td><td>Retrieve EC2 information</td>
<tr><td>Inventory</td><td>AWS Inventory</td>
<tr><td>Project</td><td>AWS Demo Project</td>
<tr><td>Playbook</td><td>playbooks/lab2-ec2-info.yml</td>
<tr><td>Credentials</td><td>AWS_credential</td>
</table>

`Credentials`については、`Select Category`ドロップダウンから`Amazon Web Services`を選択する必要があります。リストの中から`AWS_credential`を選択します。

一番下までスクロールして、`Save`をクリックします。

`Retrieve EC2 information`ジョブテンプレートを選択して、`Launch`をクリックして起動するか、`Rocket Launcher` 🚀アイコンをクリックして、ジョブテンプレートを起動します。

`ジョブテンプレートの出力を観察します。`

非常に動的な環境では、AWSインベントリー (EC2 インスタンス) が頻繁に変更される可能性があります。従って、ジョブテンプレートを実行する前にインベントリの同期をトリガーすることが重要です。`これについては、タスク4で扱いましょう。`

☑️ タスク4 - インベントリーの同期をトリガーするワークフローテンプレートの作成と、ジョブテンプレートの実行
===

ラボ上部の`Automation Controller`タブをクリックして、左のナビゲーションメニューの`Resources`グループ下の`Templates`をクリックします。

さらに、青色の`Add`ボタンをクリックし、`Add Workflow template`を選択します。

以下のように入力します:

<table>
<tr><th>Parameter</th><th>Value</th>
</tr>
<tr><td>Name</td><td>WORKFLOW - Retrieve EC2 information</td>
<tr><td>Inventory</td><td>AWS Inventory</td>
</table>

一番下までスクロールして、`Save`をクリックします。
ワークフロービジュアルデザイナーが開きます。緑色の`START`ボタンをクリックします。
`Add Node`ダイアログで、`Node Type`ドロップダウンを展開して、`Inventory Source Sync`を選択し、リストから`AWS Source`を選択、`Save`をクリックします。

この時点で、AWSインベントリーの同期をトリガーするワークフロー内の最初のノードが完成しました。`AWS Source`というタイトルのノードの上にマウスを置き、`+`記号を選択して、次のノードをワークフローに追加します。

`On Success`が選択されていることを確認します。これにより、ワークフローの最初のノードが完了するまで、次のノードに進まなくなります。`Next`を選択します。

この時点で、`Node Type`は`Job Template`になっている必要があります。リストから`Retrieve EC2 information`ジョブテンプレートを選択し、`Save`をクリックします。

ワークフローデザイナーの右上にある`Save`をクリックして、ワークフローテンプレートを保存します。

`WORKFLOW - Retrieve EC2 information`枠フローテンプレートを`Launch`します。ジョブの詳細を確認するには、各ワークフローノードを選択し、`Output`タブに移動してそのノードの実行の詳細を確認します。

これで、`Workflow template`によりAWSインベントリーを最新のインベントリーに更新し、必要なEC2の情報を取得できるようになりました。

完了したら、`次の課題に進んでください`。`Next`をクリックします。

✅ 次の課題
===

この課題を完了したら、下の`Next`ボタンをクリックして、次の課題に進みます。
