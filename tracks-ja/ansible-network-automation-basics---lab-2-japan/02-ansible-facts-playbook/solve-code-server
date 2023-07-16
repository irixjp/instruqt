#!/bin/bash

tee /home/rhel/facts.yml << EOF

---
- name: gather information from routers
  hosts: cisco
  gather_facts: no

  tasks:
    - name: gather router facts
      cisco.ios.facts:


EOF


