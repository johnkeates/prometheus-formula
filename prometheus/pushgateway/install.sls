# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}
pushgateway_server_tarball:
  archive.extracted:
    - name: {{ prometheus.pushgateway.install_dir }}
    - source: {{ prometheus.pushgateway.source }}
    - source_hash: {{ prometheus.pushgateway.source_hash }}
    - archive_format: tar
    - if_missing: {{ prometheus.pushgateway.version_path }}

pushgateway_bin_link:
  file.symlink:
    - name: /usr/bin/prometheus
    - target: {{ prometheus.pushgateway.version_path }}/prometheus
    - require:
      - archive: prometheus_server_tarball



pushgateway_defaults:
  file.managed:
    - name: /etc/default/prometheus
    - source: salt://prometheus/files/default-prometheus.jinja
    - template: jinja
    - defaults:
        config_file: {{ prometheus.pushgateway.args.config_file }}
        storage_local_path: {{ prometheus.pushgateway.args.storage.local_path }}
        web_console_libraries: {{ prometheus.pushgateway.version_path }}/console_libraries
        web_console_templates: {{ prometheus.pushgateway.version_path }}/consoles

{%- if prometheus.pushgateway.args.storage.local_path is defined %}
pushgateway_storage_local_path:
  file.directory:
    - name: {{ prometheus.pushgateway.args.storage.local_path }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - makedirs: True
    - watch:
      - file: prometheus_defaults
{%- endif %}

