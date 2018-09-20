# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/alertmanager/map.jinja" import alertmanager_server with context %}
{% from "prometheus/server/map.jinja" import prometheus_server with context %}

{% set version_path = alertmanager_server.alertmanager.install_dir + alertmanager_server.alertmanager.default_version + "/" %}
# Download the tarball
alertmanager_server_tarball:
  archive.extracted:
    - name: {{ version_path }}
    - source: {{ alertmanager_server.alertmanager.alertmanager_version_source }}
    - source_hash: {{ alertmanager_server.alertmanager.alertmanager_version_source_hash }}
    - archive_format: tar
    - if_missing: {{ version_pathh }}

# Link the extracted binary to the system path
alertmanager_bin_link:
  file.symlink:
    - name: /usr/bin/alertmanager
    - target: {{ version_path }}alertmanager-{{ alertmanager_server.alertmanager.default_version }}/alertmanager
    - require:
      - archive: alertmanager_server_tarball

# Setup startup settings
alertmanager_defaults:
  file.managed:
    - name: /etc/default/alertmanager
    - source: salt://prometheus/alertmanager/files/default-prometheus.jinja
    - template: jinja
    - defaults:
        config_file: {{ alertmanager_server.alertmanager.args.config_file }}
        storage_local_path: {{ alertmanager_server.alertmanager.args.storage.local_path }}
        web_console_libraries: {{ alertmanager_server.alertmanager.version_path }}/console_libraries
        web_console_templates: {{ alertmanager_server.alertmanager.version_path }}/consoles

# Configure path for local storage
{%- if alertmanager_server.alertmanager.args.storage.local_path is defined %}
alertmanager_storage_local_path:
  file.directory:
    - name: {{ alertmanager_server.alertmanager.args.storage.local_path }}
    - user: {{ prometheus_server.user }}
    - group: {{ prometheus_server.group }}
    - makedirs: True
    - watch:
      - file: alertmanager_defaults
{%- endif %}

