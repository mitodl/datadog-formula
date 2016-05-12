{% from "datadog/map.jinja" import datadog with context %}

datadog:
  pkg.installed:
    - pkgs: {{ datadog.pkgs }}
  service:
    - running
    - name: {{ datadog.service }}
    - enable: True
    - require:
      - pkg: datadog
