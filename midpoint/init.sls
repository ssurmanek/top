jdk-archive:
  archive.extracted:
    - name: /opt/jdk/
    - source: http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
    - source_hash: md5=99051574a0d90871ed24a91a5d321ed2
    - archive_format: tar
    - if_missing: /opt/jdk/jdk1.8.0_161

java_home:
  environ.setenv:
     - name: JAVA_HOME
     - value: /opt/jdk/jdk1.8.0_161
     - update_minion: True

midpoint.tar.gz:
  archive.extracted:
    - name: /opt/midpoint/midpoint-3.7.1-dist.tar.gz
    - source: https://evolveum.com/downloads/midpoint/3.7.1/midpoint-3.7.1-dist.tar.gz
    - source_hash: md5=1aa8e84aca1c5c24827804d5d21276f9
    - archive_format: tar
    - if_missing: /opt/midpoint/midpoint-3.7.1-dist.tar.gz
