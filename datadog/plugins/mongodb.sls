{% set dd_mongo = salt.pillar.get(
    'datadog:integrations:mongodb',
    {
        'passwd': 'Ch@ng3me!',
        'password': 'N0tS3cure!'
    }) %}

install_pymongo:
  pip.installed:
    - name: pymongo

create_datadog_mongo_user:
  mongodb_user.present:
    - name: datadog
    - passwd: {{ dd_mongo.passwd }}
    - user: admin
    - password: {{ dd_mongo.password }}
    - database: admin
