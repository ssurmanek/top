grafana_version: 4
grafana:
  grafana_timeout: 5
  grafana_user: admin
  grafana_password: admin
  grafana_url: 'http://172.17.1.64:3000'
  
  grafana4_user.present:
    - name: foobar
    - password: mypass
    - email: "foobar@localhost"
    - fullname: Foo Bar
    - is_admin: true
