update_pillar:
    salt.runner:
        - name: git_pillar.update
        - branch: master
        - repo: https://github.com/ssurmanek/users-data.git
        - order: 1
