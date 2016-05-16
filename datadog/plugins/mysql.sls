{% set dd_mysql = salt.pillar.get(
    'datadog:integrations:mysql',
    {
        'password': 'Ch@ng3me!',
        'host': '*.*',
    }) %}

create_datadog_mysql_user:
  mysql_user.present:
    - name: datadog
    - password: {{ dd_mysql.password }}
    - host: {{ dd_mysql.host }}
    {% for }
