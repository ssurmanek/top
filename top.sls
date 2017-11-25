base:
  'salt-stack-minion':
#    - clear
    - apache
    - apache.config
    - apache.vhosts.standard
    - php
    - php.mysql
    - mysql
    - sugarcrm.cli
    - sugarcrm
    
