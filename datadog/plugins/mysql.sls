{% set dd_mysql = salt.pillar.get(
    'datadog:integrations:mysql',
    {
        'datadog_password': 'Ch@ng3me!',
        'host_access': '*.*',
    }) %}

create_datadog_mysql_user:
  mysql_user.present:
    - name: datadog
    - password: {{ dd_mysql.datadog_password }}
    - host: {{ dd_mysql.host_access }}
