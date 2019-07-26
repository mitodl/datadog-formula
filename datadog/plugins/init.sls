{% from "datadog/map.jinja" import datadog with context %}

include:
  - ..service

datadog_plugin_configuration_directory:
  file.directory:
    - name: /etc/datadog-agent/conf.d

{% for name, settings in salt.pillar.get('datadog:integrations', {}).items() %}
configure_{{ name }}_integration:
  file.managed:
    - name: /etc/datadog-agent/conf.d/{{ name }}.d/conf.yaml
    - contents: |
        init_config:

        {{ settings.settings | yaml(False) | indent(8) }}
    - watch_in:
        - service: datadog_agent_service
{% endfor %}
