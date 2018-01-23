update_pillar:
    salt.runner:
        - name: git_pillar.update
        - branch: master
        - repo: https://github.com/ssurmanek/users-data.git

webserver_setup:
  salt.state:
    - tgt: '*-minion'
    - highstate: True
    - require:
      - salt: update_pillar
