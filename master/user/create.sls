{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'present' and 'salt-stack-master' in user.get('entitlements') %}
    create_user_{{ userName }}:
        user.present:
            - fullname: {{ user.get('givenName') }} {{ user.get('familyName') }}
            - password: {{ user.get('password') }}
            - name: {{ userName }}
            - home: /home/{{ userName }}
            - shell: /bin/sh
            {% if 'groups' in user %} 
            {% set groups = user.get('groups') %}
                {% for group in groups if group.split(':')[0] == 'salt-stack-master' %}
            - groups: group.split(':')[1].split(',')
                {% endfor %}
        {% endif %}
    {% endif %}
{% endfor %}
