#!/bin/bash

tee /home/rhel/banner-survey.json << EOF
{
    "name": "",
    "description": "",
    "spec": [
        {
            "question_name": "Please enter the banner text",
            "question_description": "Please type into the text field the desired banner",
            "required": true,
            "type": "textarea",
            "variable": "net_banner",
            "min": 0,
            "max": 1024,
            "default": "",
            "choices": "",
            "new_question": true
        },
        {
            "question_name": "Please enter the banner type",
            "question_description": "Please choose an option",
            "required": true,
            "type": "multiplechoice",
            "variable": "net_type",
            "min": 0,
            "max": 1024,
            "default": "",
            "choices": "login\nmotd",
            "new_question": true
        }
    ]
}

EOF

tee /home/rhel/solve_challenege_2.yml << EOF
---
- hosts: localhost
  connection: local
  gather_facts: false
  tasks:
    - name: Create network backup job template
      awx.awx.job_template:
        name: "Network-Banner"
        job_type: "run"
        organization: "Default"
        inventory: Network Inventory
        project: "Network Toolkit"
        playbook: "playbooks/network_banner.yml"
        credentials:
          - "Network Credential"
        state: "present"
        controller_config_file: "/tmp/setup-scripts/controller.cfg"
        survey_enabled: yes
        survey_spec: "{{ lookup('file', 'banner-survey.json') }}"
EOF

sudo chown rhel:rhel /home/rhel/solve_challenege_2.yml

su - rhel -c 'ansible-playbook /home/rhel/solve_challenege_2.yml'
