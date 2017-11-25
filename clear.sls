sugarcrm_rmv:
  pkg.purged:
    - name: sugarcrm

apache_rmv:
  pkg.purged:
    - name: apache2

php_rmv:
  pkg.purged:
    - name: 
      - php
      - php.mysql
      - php.zip
      - php.ng
      - php.ng.mysql
      - php.ng.zip

mysql_rmv:
  pkg.purged:
    - name: mysql
