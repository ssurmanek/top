{% set jdk_home = salt['pillar.get']('midpoint:jdk-home', "/opt/jdk") %}
{% set midpoint_dir = salt['pillar.get']('midpoint:base-dir', "/opt/midpoint") %}
{% set midpoint_version = salt['pillar.get']('midpoint:version', "3.7.1") %}
{% set midpoint_checksum = salt['pillar.get']('midpoint:checksum', None) %}
{% set user_name = salt['pillar.get']('midpoint:user:name', "midpoint") %}

get-jdk-archive:
  cmd.run:
    - name: |
        mkdir -p {{ jdk_home }}
        wget --no-check-certificate -c --header 'Cookie: oraclelicense=accept-securebackup-cookie' http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz -P /opt/jdk
    - shell: /bin/bash
    
midpoint-user:
  user.present:
    - name: {{ user_name }}
    - password: {{ salt['pillar.get']('midpoint:user:password', "5ecr3t") }}
    - groups:
        - sudo

jdk-archive:
  archive.extracted:
    - name: {{ jdk_home }}
    - source: {{ jdk_home }}/jdk-8u161-linux-x64.tar.gz
    - archive_format: tar
    - options: xzf
    - if_missing: {{ jdk_home }}/jdk1.8.0_161
    - require:
        - cmd: get-jdk-archive

java-alternatives:
  alternatives.install:
    - name: java
    - link: /usr/bin/java
    - path: {{ jdk_home }}/jdk1.8.0_161/bin/java
    - priority: 100
    - require: 
      - archive: jdk-archive
    
javac-alternatives:
  alternatives.install:
    - name: javac
    - link: /usr/bin/javac
    - path: {{ jdk_home }}/jdk1.8.0_161/bin/javac
    - priority: 100
    - require: 
      - archive: jdk-archive

java_home:
  environ.setenv:
     - name: JAVA_HOME
     - value: {{ jdk_home }}/jdk1.8.0_161
     - update_minion: True

midpoint.tar.gz:
  archive.extracted:
    - name: {{ midpoint_dir }}
    - source: https://evolveum.com/downloads/midpoint/{{ midpoint_version }}/midpoint-{{ midpoint_version }}-dist.tar.gz
    {% if midpoint_checksum %}
    - source_hash: {{ midpoint_checksum }}
    {% else %}
    - skip_verify: True
    {% endif %}
    - archive_format: tar
    - user: {{ user_name }}
    - if_missing: {{ midpoint_dir }}
    - enforce_ownership_on: {{ midpoint_dir }}/midpoint-{{ midpoint_version }}
    - require:
        - user: midpoint-user

#run-midpoint:
#  cmd.run:
#    - name: |
#        java -Xmx2048M -Xms2048M -Dfile.encoding=UTF8 -Dmidpoint.home=/opt/midpoint-3.7.1 -jar /opt/midpoint-3.7.1/lib/midpoint.war
#    - require: 
#        - environ: java_home

run-midpoint:
  cmd.script:
    - name: {{ midpoint_dir }}/midpoint-{{ midpoint_version }}/bin/start.sh
    - shell: /bin/bash
    - cwd: {{ midpoint_dir }}/midpoint-{{ midpoint_version }}/bin
    - runas: midpoint
    - require: 
        - environ: java_home
        - user: midpoint-user
