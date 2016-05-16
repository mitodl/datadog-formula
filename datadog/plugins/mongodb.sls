{% set dd_mongo = salt.pillar.get(
    'datadog:integrations:mongodb',
    {
        'datadog_passwordd': 'Ch@ng3me!',
        'admin_password': 'N0tS3cure!'
    }) %}

install_pymongo:
  pip.installed:
    - name: pymongo

create_datadog_mongo_user:
  mongodb_user.present:
    - name: datadog
    - passwd: {{ dd_mongo.datadog_password }}
    - user: admin
    - password: {{ dd_mongo.admin_password }}
    - database: admin
