{% from "datadog/map.jinja" import datadog with context %}

test_datadog_package_archive_configured:
  testinfra.file:
    {% if grains['os_family'].lower() == 'debian' %}
    - name: /etc/apt/sources.list.d/datadog.list
    - exists: True
    - contains:
        parameter: https://apt.datadoghq.com/
        expected: True
        comparison: is_
    {% elif grains['os_family'].lower() == 'redhat' %}
    - name: /etc/yum.repos.d/datadog.repo
    - contains:
        parameter: https://yum.datadoghq.com/rpm
        expected: True
        comparison: is_
    {% endif %}

test_datadog_package_installed:
  testinfra.package:
    - name: {{ datadog.pkg_name }}
    - is_installed: True

test_datadog_config_file:
  testinfra.file:
    - name: /etc/dd-agent/datadog.conf
    - exists: True
    - contains:
        parameter: app.datadoghq.com
        expected: True
        comparison: is_
