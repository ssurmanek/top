get-jdk-archive:
  cmd.run:
    - name: |
        mkdir -p /opt/jdk
        wget --no-check-certificate -c --header 'Cookie: oraclelicense=accept-securebackup-cookie' http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz -P /opt/jdk
    - shell: /bin/bash

jdk-archive:
  archive.extracted:
    - name: /opt/jdk/
    - source: /opt/jdk/jdk-8u161-linux-x64.tar.gz
    - archive_format: tar
    - options: xzf
    - if_missing: /opt/jdk/jdk1.8.0_161
    - require:
        - cmd: get-jdk-archive

java-alternatives:
  alternatives.install:
    - name: java
    - link: /usr/bin/java
    - path: /opt/jdk/jdk1.8.0_161/bin/java
    - priority: 100
    - require: 
      - archive: jdk-archive
    
javac-alternatives:
  alternatives.install:
    - name: javac
    - link: /usr/bin/javac
    - path: /opt/jdk/jdk1.8.0_161/bin/javac
    - priority: 100
    - require: 
      - archive: jdk-archive

java_home:
  environ.setenv:
     - name: JAVA_HOME
     - value: /opt/jdk/jdk1.8.0_161
     - update_minion: True

midpoint.tar.gz:
  archive.extracted:
    - name: /opt/
    - source: https://evolveum.com/downloads/midpoint/3.7.1/midpoint-3.7.1-dist.tar.gz
    - source_hash: md5=1aa8e84aca1c5c24827804d5d21276f9
    - archive_format: tar
    - if_missing: /opt/midpoint-3.7.1-dist.tar.gz
    
midpoint_home:
  environ.setenv:
     - name: MIDPOINT_HOME
     - value: /opt/midpoint-3.7.1
     - update_minion: True

#run-midpoint:
#  cmd.run:
#    - name: |
#        java -Xmx2048M -Xms2048M -Dfile.encoding=UTF8 -Dmidpoint.home=/opt/midpoint-3.7.1 -jar /opt/midpoint-3.7.1/lib/midpoint.war
#    - require: 
#        - environ: java_home

run-midpoint:
  cmd.script:
    - name: /opt/midpoint-3.7.1/bin/start.sh
    - shell: /bin/bash
    - cwd: /opt/midpoint-3.7.1/bin
    - require: 
        - environ: java_home
        - environ: midpoint_home
