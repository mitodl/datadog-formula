{% from "datadog/map.jinja" import datadog with context %}

datadog_plugin_configuration_directory:
  file.directory:
    - name: /etc/dd-agent/datadog.conf.d
