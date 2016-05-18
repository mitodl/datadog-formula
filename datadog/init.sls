{% from "datadog/map.jinja" import datadog with context %}

include:
  - .service

datadog_pkg_dependencies:
  pkg.installed:
    - pkgs: {{ datadog.pkg_deps + datadog.plugin_pkgs }}
    - refresh: True

{% if grains['os_family'].lower() == 'redhat' %}
install_datadog_repo_gpg_key:
  cmd.run:
    - name: rpm --import https://yum.datadoghq.com/DATADOG_RPM_KEY.public
    - require_in:
        - pkgrepo: datadog_package_archive
{% endif %}

datadog_package_archive:
  pkgrepo.managed:
    - humanname: 'Datadog Agent'
    {% if grains['os_family'].lower() == 'debian' %}
    - name: deb https://apt.datadoghq.com/ stable main
    - keyserver: keyserver.ubuntu.com
    - keyid: C7A7DA52
    - file: /etc/apt/sources.list.d/datadog.list
    - require:
        - pkg: datadog_pkg_dependencies
    {% elif grains['os_family'].lower() == 'redhat' %}
    - name: datadog
    - baseurl: https://yum.datadoghq.com/rpm/{{ grains['cpuarch'] }}/
    - keyurl: https://yum.datadoghq.com/DATADOG_RPM_KEY.public
    - enabled: True
    - gpgcheck: True
    {% endif %}

datadog_package:
  pkg.latest:
    - name: {{ datadog.pkg_name }}
    - refresh: True
    - require:
        - pkgrepo: datadog_package_archive
    - require_in:
        - service: datadog_agent_service

datadog_configuration:
  file.managed:
    - name: /etc/dd-agent/datadog.conf
    - watch_in:
        - service: datadog_agent_service
    - contents: |
        [Main]
        api_key: {{ salt.pillar.get('datadog:api_key', '') }}
        {{ datadog.config | yaml(False) | indent(8) }}
