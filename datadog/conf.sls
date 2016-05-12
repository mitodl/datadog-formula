{% from "datadog/map.jinja" import datadog, datadog_config with context %}

include:
  - datadog

datadog-config:
  file.managed:
    - name: {{ datadog.conf_file }}
    - source: salt://datadog/templates/conf.jinja
    - template: jinja
    - context:
      config: {{ datadog_config }}
    - watch_in:
      - service: datadog
    - require:
      - pkg: datadog
