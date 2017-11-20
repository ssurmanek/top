base:
  'salt-stack-minion':
#    - clear
    - apache
    - apache.config
    - apache.vhosts.standard
    - php.ng
    - php.ng.mysql
    - mysql
    - sugarcrm
