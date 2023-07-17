---
slug: create-workflow-template
id: mujfloioeebf
type: challenge
title: ワークフローテンプレートの作成
teaser: Automation Controller 上で複数のジョブテンプレートを連結したワークフローテンプレートを作成します。
notes:
- type: text
  contents: |
    # ネットワーク自動化の基礎 - ワークフローの作成

    Automation Controller の[ワークフロー](https://docs.ansible.com/automation-controller/latest/html/userguide/workflows.html) 機能を試します。ワークフローを使用すると、インベントリ、プレイブック、権限を共有する、または共有 しない、一連の異なるジョブテンプレート（またはワークフローテンプレート）を設定できます。

    この演習では、タイムスタンプ付きのバックアップを作成し、バックアップジョブが正常に完了した場合、ワークフローは同時にバナーとユーザーを構成します。いずれかのジョブテンプレートが失敗した場合、タイムスタンプ付きバックアップにリストアします。
- type: text
  contents: '![picture of workflows overview](https://github.com/IPvSean/pictures_for_github/blob/master/workflows-overview.png?raw=true)'
- type: text
  contents: '![picture of create workflow](https://github.com/IPvSean/pictures_for_github/blob/master/workflows-create.png?raw=true)'
- type: text
  contents: '![picture of visualizer](https://github.com/IPvSean/pictures_for_github/blob/master/workflows-visualizer.png?raw=true)'
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

    ラボのセットアップが完了したら、このウィンドウの右下にある緑のスタートボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックします。
- type: text
  contents: '![example of full workflow](https://github.com/IPvSean/pictures_for_github/blob/master/workflows-example.png?raw=true)'
tabs:
- title: Automation controller WebUI
  type: service
  hostname: controller
  port: 443
- title: Automation controller Terminal
  type: terminal
  hostname: controller
difficulty: basic
timelimit: 500
---
この演習では、Automation controller上で自動化ジョブを実行します。

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

ステップ1 - ワークフローの作成
===

- 左のナビゲーションメニューの Resources の下にある **Templates** をクリックして、**Job Templates**に移動します。 <img src="https://github.com/IPvSean/pictures_for_github/blob/master/job_templates.png?raw=true">
- 作成された **Job Templates** が表示されます。 ジョブテンプレートは Ansible playbook コンテンツの再利用とチーム間のコラボレーションを促進します。

- 青い Add ボタンをクリックし、**Add workflow template** を選択します。

   ![add workflow template button](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/controller_add_workflow.png)
- 以下の値を割り当てます:

<table>
  <tr>
    <th>Parameter</th>
    <th>Name</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>Workshop Workflow</td>
  </tr>
  <tr>
    <td>Organization</td>
    <td>Default</td>
  </tr>
  <tr>
    <td>Inventory</td>
    <td>Network Inventory</td>
  </tr>
</table>

- 青色の save ボタンをクリックします

ステップ2：ワークフロー・ビジュアライザー
===

1. ワークフローを保存すると自動的にビジュアライザーが起動します。もし起動しない場合はビジュアライザータブをクリックします。

   ![visualizer tab](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/visualizer_tab.png)

2. デフォルトで緑色の start ボタンのみが存在します。この start ボタンをクリックします。

3. **Add Node** ウインドが表示されます

   - ノードタイプに `Job Template` を選択
   - `Backup network configurations` を選択 <br><br>

4. 青色の **Save** ボタンをクリック

  ワークフローは以下のようになるはずです:

   ![picture of workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step2_workflow.png)

> バックアップネットワーク構成のジョブテンプレートがノードになりました。ジョブテンプレートまたはワークフローテンプレートは、ノードと呼ばれるグラフのような構造を使用してリンクされます。これらのノードは承認、ジョブ、プロジェクト同期、インベントリ同期、または他のワークフローであることもあります。テンプレートは異なるワークフローの一部であることも、同じワークフローで複数回使用することもできます。

ステップ 3: バナー設定ジョブテンプレートの追加
===

1. `Backup network configurations` ノードにカーソルを合わせ、+ マークをクリックします。`Add Node` ウィンドウが再び表示されます。

2. **Run type** はドロップダウンメニューから **On Success** を選択してください。青い **Next** ボタンを押してください。

   ![picture of add node window](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step3_add_node.png)

   > ワークフローは、前のノードが成功したとき、失敗したとき、または前のジョブが何をしたかに関係なく常に実行されるように、自動化ジョブを実行するように構成できます。これにより、ワークフローは問題を修正したり、デバイスの状態を戻したりすることができます。

3. `Network Automation - Banner` ジョブテンプレートを選択します。

   - 青色の Next ボタンをクリック

4. サーベイへの入力を行う

   例、バナーテキストを `This network device was configured with an Ansible workflow!` に設定し、バナータイプは `login` に設定する。

   ![add node network-banner](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step3_add_network_survey.png)

5. **Next** をクリックし、その後 **Save** をクリック

Backup network configurations と Configure Banner の間に緑色の線があるはずです:

   ![picture of two nodes in the workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step3_final.png)

ステップ 4: Network-User ジョブテンプレートの追加
===

1. `Backup network configurations`ノード（`Configure Banner`ノードではないので注意）にカーソルを合わせ、`+` のシンボルをクリックします。Add Nodeが再び表示されます。

2. **Run type** はドロップダウンメニューから **On Success** を選択してください。青い**Next**ボタンを押してください。

3. `Network Automation - User` ジョブテンプレートを選択します。

   ![picture of add node network-user](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step4_add_node.png)

4. サーベイに記入する（デフォルトの `ansible` ユーザーを設定するようにしても構いません）

5. **Next** をクリックし、その後 **Save** をクリックします。

   ![picture of workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step4_final.png)

ステップ 5: リストア用のジョブテンプレートを追加
===

1. `Network Automation - Banner`ノードにカーソルを合わせ、`+`記号をクリックします。ノードの追加」ウィンドウが再び表示されます。

2. `Run type` に `On Failure` を選択します。

   ![on failure example](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step5_on_failure.png)

   - **Next** ボタンをクリック

3. Network Automation - Restore ジョブテンプレートを選択

   ![example of network restore](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step5_add_node_restore.png)

4. ロールバックの日付を選択し、`Next`と`Save`をクリックする。

   ![picture of current workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step5_final.png)

ステップ6：コンバージド・リンクの作成
===


1. **Network Automation - User** ノードにカーソルを合わせ、チェーン ![chain picture](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/chain.png) シンボルをクリックします。

2. ここで、既存の **Network Automation - Restore** をダブルクリックする。 **Add Link** ウィンドウが表示されます。`RUN` パラメーターは **On Failure** を選択します。

   ![add link picture](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step6_on_fail.png)

3. **Save** をクリックします。

   - 以下のワークフローが完成したはずです:

   ![picture of workflow](https://aap2.demoredhat.com/exercises/ansible_network/9-controller-workflow/images/step6_complete_workflow.png)


4. 最後に **save** をクリックし、ワークフロー全体を保存します。

ステップ7 - 確認
===

ワークフローが作成されたことを確認するために、下の緑色の`Check`ボタンをクリックしてください。
