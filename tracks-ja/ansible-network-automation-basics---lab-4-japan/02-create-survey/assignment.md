---
slug: create-survey
id: z9rntujmmgz7
type: challenge
title: サーベイの作成
teaser: 基本演習4の課題2では Automation Controller でサーベイの作成する方法を学びます
notes:
- type: text
  contents: |
    # 課題 2 - サーベイの作成

    この課題では、ユーザーから入力を収集し、変数 `net_banner` と `banner_type` の値を入力するために、ユーザー入力フォームの「サーベイ」を作成する。


    まだプロビジョニングが開始されていない場合は、右下の緑色の開始ボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックしてください。
- type: text
  contents: |
    # Playbook の確認

    ```yaml
    - name: set router banners
      hosts: routers
      gather_facts: no

      tasks:
        - name: load banner onto network device
          vars:
            - network_banner:  "{{ net_banner | default(None) }}"
            - banner_type: "{{ net_type | default('login') }}"
          include_role:
            name: "../roles/banner"
    ```

    使用するPlaybookの全体は [Ansible Playbook here](https://github.com/network-automation/toolkit/blob/master/playbooks/network_banner.yml) から確認できます。

    ロール **banner** には非常にシンプルな main.yml ファイルがあります:

    ```yaml
    - name: configure banner
      include_tasks: "{{ ansible_network_os }}.yml"
    ```

    `ansible_network_os` 変数は、ネットワークOSをパラメータ化し、ベンダーに依存しないPlaybookを作成するために使用される。

    junosデバイスを使っている場合、このプレイブックはjunos.ymlというタスクファイルを呼び出す。IOS-XEデバイスを使っている場合、このプレイブックはios.ymlというタスクファイルを呼び出します。このファイルには、プラットフォーム固有のタスクが含まれる:

    ```
    - name: add the junos banner
      junos_banner:
        text: "{{ network_banner }}"
        banner: "{{ banner_type }}"
    ```
- type: text
  contents: |-
    また、タスク・ファイルに2つの変数を渡していることにも注意してください。

    1. `network_banner`: この変数には `net_banner` 変数を使用する。

    2. `banner_type`: この変数には `net_type` という変数が代入される。
- type: text
  contents: |-
    サーベイを有効であることを確認してください。

    ![picture of survey enabled](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey_toggle.png)
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
- title: Visual Studio Code
  type: service
  hostname: controller
  path: /editor/
  port: 443
difficulty: basic
timelimit: 600
---
Automation Controllerにログインします
===

ログアウトしている場合は、automation controller にログインし直します。
<br><br>
画面上部の `Automation controller WebUI` タブを選択します。

以下の認証情報でログインします:

username: `admin`<br>
password: `ansible123!`

ステップ1 - Network-Banner ジョブテンプレートに移動する
===

- 左のナビゲーションメニューのリソースの下にある**Templates** をクリックして、**Job Templates**に移動します。 <img src="https://github.com/IPvSean/pictures_for_github/blob/master/job_templates.png?raw=true">
- 作成された** Job Templates**が表示されます。
-  **Network-Banner** ジョブテンプレートをクリックします。

ステップ 2 - サーベイの作成
===

このステップでは、ユーザーから入力を収集し、変数 net_banner と banner_type の値を入力するために、ユーザー入力フォームの `survey` を作成します。

1. Network-Banner ジョブテンプレートの中の Survey タブをクリックします。

   ![image of survey button](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_job_survey.png)

2. 青色の Add ボタンをクリックします

   ![image of blue add button](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_add_survey.png)

3. フィールドに以下を記入します

    <table>
      <tr>
        <th>Parameter	</th>
        <th>Value
    </th>
      </tr>
      <tr>
        <td>Question</td>
        <td>Please enter the banner text</td>
      </tr>
      <tr>
        <td>Description</td>
        <td>Please type into the text field the desired banner</td>
      </tr>
      <tr>
        <td>Answer Variable Name</td>
        <td>net_banner</td>
      </tr>
      <tr>
        <td>Answer type	</td>
        <td>Textarea</td>
      </tr>
      <tr>
        <td>Required</td>
        <td>Checkmark ✅</td>
      </tr>
    </table>

   以下の画像が入力例です: (全体を表示するにはウィンドウを左にドラッグする必要があるかもしれません):
   ![picture of survey](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey_q_one.png)

4. Save をクリック

5. サーベイタブに戻って青い追加ボタンをクリックし、別の質問を作成します。

   ![picture of blue add button](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_add_survey.png)

6. 次に、`banner_type` を収集するためのプロンプトを作成します。これは `motd` または `login` のどちらかになり、上記のプレイブックに従ってデフォルトは "login" になります。
    <table>
      <tr>
        <th>Parameter	</th>
        <th>Value
    </th>
      </tr>
      <tr>
        <td>Question</td>
        <td>Please enter the banner type</td>
      </tr>
      <tr>
        <td>Description</td>
        <td>Please choose an option</td>
      </tr>
      <tr>
        <td>Answer Variable Name</td>
        <td><code>net_type</code></td>
      </tr>
      <tr>
        <td>Answer type</td>
        <td>Multiple Choice(single select)</td>
      </tr>
      <tr>
        <td>Multiple Choice Options</td>
        <td><ul><li>login</li><li>motd</li></ul></td>
      </tr>
      <tr>
        <td>default answer	</td>
        <td>login</td>
      </tr>
      <tr>
        <td>Required</td>
        <td>Checkmark ✅</td>
      </tr>
    </table>

   例:  ![image of survey](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey_q_two.png)

7. Save をクリック

8. トグルスイッチが `Survey Enabled` に設定されていることを確認する。

   ![picture of survey enabled](https://aap2.demoredhat.com/exercises/ansible_network/7-controller-survey/images/controller_survey_toggle.png)

# 課題は終了です！
