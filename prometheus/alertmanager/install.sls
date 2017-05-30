# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}
alertmanager_server_tarball:
  archive.extracted:
    - name: {{ prometheus.alertmanager.install_dir }}
    - source: {{ prometheus.alertmanager.source }}
    - source_hash: {{ prometheus.alertmanager.source_hash }}
    - archive_format: tar
    - if_missing: {{ prometheus.alertmanager.version_path }}

alertmanager_bin_link:
  file.symlink:
    - name: /usr/bin/alertmanager
    - target: {{ prometheus.alertmanager.version_path }}/alertmanager
    - require:
      - archive: prometheus_server_tarball



alertmanager_defaults:
  file.managed:
    - name: /etc/default/alertmanager
    - source: salt://prometheus/alertmanager/files/default-prometheus.jinja
    - template: jinja
    - defaults:
        config_file: {{ prometheus.alertmanager.args.config_file }}
        storage_local_path: {{ prometheus.alertmanager.args.storage.local_path }}
        web_console_libraries: {{ prometheus.alertmanager.version_path }}/console_libraries
        web_console_templates: {{ prometheus.alertmanager.version_path }}/consoles

{%- if prometheus.alertmanager.args.storage.local_path is defined %}
alertmanager_storage_local_path:
  file.directory:
    - name: {{ prometheus.alertmanager.args.storage.local_path }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - makedirs: True
    - watch:
      - file: prometheus_defaults
{%- endif %}

