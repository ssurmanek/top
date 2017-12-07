base:
  'salt-stack-minion':
#    - clear
    - apache
    - apache.config
    - apache.vhosts.standard
    - php
    - php.mysql
    - php.zip
    - mysql
    - sugarcrm.cli
    - sugarcrm   
    - sugarcrm.user-list
    - create-linux-user
  'elk-minion':
    - kibana.init
  'elk-5':
    - elk
