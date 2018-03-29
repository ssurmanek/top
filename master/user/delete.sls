{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'absent' and 'master' in user.get('xentitlements') %}
    delete_user_{{ userName }}:
        user.absent:
            - name: {{ userName }}
    {% endif %}
{% endfor %}
