---
slug: playground
id: x1wnhrrtpdgp
type: challenge
title: Playground
teaser: 残りの時間を使って、ご自身で試してみてください。この課題はチェックされませんので、 ご自由にいろいろと試してみてください。
notes:
- type: text
  contents: 残りの時間は Ansible で遊んで楽しみましょう!
tabs:
- title: control
  type: terminal
  hostname: control
difficulty: basic
timelimit: 1
---
👋 はじめに
===
残りの時間を自由に使って、Ansible Playbook で何ができるかを探ってください。

man ページから Ansible ドキュメントに直接アクセスできることをご存知ですか?

たとえば、Web からファイルをダウンロードする方法について詳しく知りたいと想像してみてください。

チェック:

```
ansible-doc ansible.builtin.get_url
```

ラボをお楽しみください。

✅次の場所
===

自動化への取り組みを始めたばかりの方でも、経験豊富なベテランの方でも、自動化の知識を深めるためのさまざまなリソースを利用できます:

* [Self-paced exercises](https://www.redhat.com/en/engage/redhat-ansible-automation-202108061218) - 全ての self-paced labs をご確認ください
* [Trial subscription](http://red.ht/try_ansible) - お使いの環境にインストールする準備はできていますか?Ansible Automation Platform のすべてのコンポーネントに無制限にアクセスするには、トライアルサブスクリプションを取得してください。
* [Red Hat Ansible Automation Platform YouTube channel をサブスクライブします ](https://www.youtube.com/ansibleautomation)

<style type="text/css" rel="stylesheet">
  .lightbox {
    display: none;
    position: fixed;
    justify-content: center;
    align-items: center;
    z-index: 999;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    padding: 1rem;
    background: rgba(0, 0, 0, 0.8);
    margin-left: auto;
    margin-right: auto;
    margin-top: auto;
    margin-bottom: auto;
  }
  .lightbox:target {
    display: flex;
  }
  .lightbox img {
    /* max-height: 100% */
    max-width: 60%;
    max-height: 60%;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
  }
  h1 {
    font-size: 18px;
  }
    h2 {
    font-size: 16px;
    font-weight: 600
  }
    h3 {
    font-size: 14px;
    font-weight: 600
  }
  p span {
    font-size: 14px;
  }
  ul li span {
    font-size: 14px
  }
</style>
