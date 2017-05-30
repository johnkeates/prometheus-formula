# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}
prometheus_server_tarball:
  archive.extracted:
    - name: {{ prometheus.server.install_dir }}
    - source: {{ prometheus.server.source }}
    - source_hash: {{ prometheus.server.source_hash }}
    - archive_format: tar
    - if_missing: {{ prometheus.server.version_path }}

prometheus_bin_link:
  file.symlink:
    - name: /usr/bin/prometheus
    - target: {{ prometheus.server.version_path }}/prometheus
    - require:
      - archive: prometheus_server_tarball



prometheus_defaults:
  file.managed:
    - name: /etc/default/prometheus
    - source: salt://prometheus/server/files/default-prometheus.jinja
    - template: jinja
    - defaults:
        config_file: {{ prometheus.server.args.config_file }}
        storage_local_path: {{ prometheus.server.args.storage.local_path }}
        web_console_libraries: {{ prometheus.server.version_path }}/console_libraries
        web_console_templates: {{ prometheus.server.version_path }}/consoles

{%- if prometheus.server.args.storage.local_path is defined %}
prometheus_storage_local_path:
  file.directory:
    - name: {{ prometheus.server.args.storage.local_path }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - makedirs: True
    - watch:
      - file: prometheus_defaults
{%- endif %}

