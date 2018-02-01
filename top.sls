base:
#  'salt-stack-minion':
#    - clear
#    - apache
#    - apache.config
#    - apache.vhosts.standard
#    - php
#    - php.mysql
#    - php.zip
#    - mysql
#    - sugarcrm.cli
#    - sugarcrm   
#    - sugarcrm.user-list
#    - create-linux-user
#    - grafana
#  'elk-minion':
#    - kibana.init
#  'elk-5':
#    - elk
#  'salt-stack-master':
#    - linux.user.create
#    - linux.user.delete
  'grafana-minion':
    - grafana.user.create
    - grafana.user.delete
  'wso2-minion':
    - wso2.user.create
    - wso2.user.delete
