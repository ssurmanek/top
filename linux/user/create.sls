{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'present' and 'linux' in user.get('groups') %}
    create_user_{{ userName }}:
        user.present:
            - fullname: {{ user.get('givenName') }} {{ user.get('familyName') }}
            - password: {{ user.get('password') }}
            - name: {{ userName }}
            - home: /home/{{ userName }}
            - shell: /bin/sh
    {% endif %}
{% endfor %}
