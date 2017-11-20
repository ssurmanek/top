base:
  'salt-stack-minion':
    - apache
    - apache.config
    - apache.vhosts.standard
    - php.ng
    - php.ng.mysql
    - mysql
    - sugarcrm.cli
    - sugarcrm
    - sugarcrm.config