base:
  'salt-stack-master':
    - update_pillar
  'grafana-minion':
    - grafana.user.delete
  'wso2-minion':
    - wso2.user.delete
