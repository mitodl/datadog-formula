{% from "datadog/map.jinja" import datadog with context %}
{% set api_key = salt.pillar.get('datadog:api_key', '') %}

include:
  - .service

datadog_pkg_dependencies:
  pkg.installed:
    - pkgs: {{ datadog.pkg_deps + datadog.plugin_pkgs }}
    - refresh: True

datadog_install:
  cmd.run:
    - name: curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh
    - env:
      - DD_AGENT_MAJOR_VERSION: {{ datadog.major_version }}
      - DD_API_KEY: {{ api_key }}
      - DD_SITE: "datadoghq.com"

datadog_configuration:
  file.managed:
    - name: /etc/datadog-agent/datadog.yaml
    - watch_in:
        - service: datadog_agent_service
    - contents: |
        api_key: {{ api_key }}
        {{ datadog.config | yaml(False) | indent(8) }}
