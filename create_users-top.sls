base:
  'salt-stack-master':
    - update_pillar
  'grafana-minion':
    - grafana.user.create
  'wso2-minion':
    - wso2.user.create
