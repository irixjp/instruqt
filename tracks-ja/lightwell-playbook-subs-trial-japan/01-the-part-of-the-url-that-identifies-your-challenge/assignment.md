---
slug: the-part-of-the-url-that-identifies-your-challenge
type: challenge
title: This will be the title of your challenge
teaser: A small description of your challenge with a max of 1-2 sentences
notes:
- type: text
  contents: Here we can give the end user some information while the environment is
    being started. Notes can contain text, images and video. Notice the arrow to the
    right?
- type: text
  contents: You can create as many notes as you need. You can use markdown here.
tabs:
- title: tower
  type: service
  hostname: tower
  port: 443
- title: editor
  type: service
  hostname: tower
  path: /editor/
  port: 443
- title: ansible-cli
  type: terminal
  hostname: tower
- title: rhel-cli
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 5000
---
The full assignment of the challenge. You can use markdown here.