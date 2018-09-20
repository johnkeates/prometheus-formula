# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/alertmanager/map.jinja" import alertmanager_server with context %}
{% from "prometheus/server/map.jinja" import prometheus_server with context %}

{{ alertmanager_server|pprint }}

alertmanager_server_tarball:
  archive.extracted:
    - name: {{ alertmanager_server.install_dir }}
    - source: {{ alertmanager_server.source }}
    - source_hash: {{ alertmanager_server.source_hash }}
    - archive_format: tar
    - if_missing: {{ alertmanager_server.version_path }}

alertmanager_bin_link:
  file.symlink:
    - name: /usr/bin/alertmanager
    - target: {{ alertmanager_server.version_path }}/alertmanager
    - require:
      - archive: prometheus_server_tarball



alertmanager_defaults:
  file.managed:
    - name: /etc/default/alertmanager
    - source: salt://prometheus/alertmanager/files/default-prometheus.jinja
    - template: jinja
    - defaults:
        config_file: {{ alertmanager_server.args.config_file }}
        storage_local_path: {{ alertmanager_server.args.storage.local_path }}
        web_console_libraries: {{ alertmanager_server.version_path }}/console_libraries
        web_console_templates: {{ alertmanager_server.version_path }}/consoles

{%- if alertmanager_server.args.storage.local_path is defined %}
alertmanager_storage_local_path:
  file.directory:
    - name: {{ alertmanager_server.args.storage.local_path }}
    - user: {{ prometheus_server.user }}
    - group: {{ prometheus_server.group }}
    - makedirs: True
    - watch:
      - file: alertmanager_defaults
{%- endif %}

