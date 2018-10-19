# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/server/map.jinja" import prometheus_server as prometheus with context %}


{% set version_path = prometheus.server.install_dir + prometheus.server.default_version + "/" %}
# Download the tarball
prometheus_server_tarball:
  archive.extracted:
    - name: {{ version_path }}
    - source: {{ prometheus.server_version_source }}
    - source_hash: {{ prometheus.server_version_source_hash }}
    - archive_format: tar
    - if_missing: {{ version_path }}

# Link the extracted binary to the system path
prometheus_bin_link:
  file.symlink:
    - name: /usr/bin/prometheus
    - target: {{ version_path }}prometheus-{{ prometheus.server.default_version }}/prometheus
    - require:
      - archive: prometheus_server_tarball

# Setup startup settings
prometheus_defaults:
  file.managed:
    - name: /etc/default/prometheus
    - source: salt://prometheus/server/files/prometheus.defaults.jinja
    - template: jinja
    - defaults:
        config_file: {{ prometheus.server.args.config_file }}
        storage_local_path: {{ prometheus.server.args.storage.local_path }}
        web_console_libraries: {{ version_path }}prometheus-{{ prometheus.server.default_version }}/console_libraries
        web_console_templates: {{ version_path }}prometheus-{{ prometheus.server.default_version }}/consoles

# Configure path for local storage
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
{%- if prometheus.server.args.alerting_rules_dir is defined %}
prometheus_storage_alerts_dir:
  file.directory:
    - name: {{ prometheus.server.args.alerting_rules_dir }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - makedirs: True
    - watch:
      - file: prometheus_defaults
{%- endif %}