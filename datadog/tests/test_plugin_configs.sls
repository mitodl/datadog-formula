{% set integrations = salt.pillar.get('datadog:integrations', {}) %}

{% for name, settings in integrations.items() %}
ensure_{{ name }}_integration_settings_files_configured:
  testinfra.file:
    - name: /etc/dd-agent/conf.d/{{ name }}.yml
    - exists: True
    - contains:
        parameter: init_config
        expected: True
        comparison: is_
{% endfor %}
