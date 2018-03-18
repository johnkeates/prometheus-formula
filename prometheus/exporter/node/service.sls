# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/node/map.jinja" import prometheus_exporter_node as prometheus with context %}

node_exporter_service_unit:
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - source: salt://prometheus/exporter/node/files/node_exporter.systemd.jinja
    - template: jinja
    - watch:
      - file: node_exporter_defaults
    - require_in:
      - file: node_exporter_service

node_exporter_service:
  service.running:
    - name: node_exporter
    - enable: True
    - reload: True
    - watch:
      - file: node_exporter_service_unit
      - file: node_exporter_bin_link