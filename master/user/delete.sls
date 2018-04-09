{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'absent' and 'salt-stack-master' in user.get('entitlements') %}
    delete_user_{{ userName }}:
        user.absent:
            - name: {{ userName }}
    {% endif %}
{% endfor %}
