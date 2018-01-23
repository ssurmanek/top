update_pillar:
    salt.runner:
        - name: git_pillar.update
        - branch: master
        - repo: https://github.com/ssurmanek/users-data.git

grafana_top:
  salt.state:
    - tgt: 'grafana-minion'
    - highstate: True
    - require:
      - salt: update_pillar

wso2_top:
  salt.state:
    - tgt: 'wso2-minion'
    - highstate: True
    - require:
      - salt: update_pillar
