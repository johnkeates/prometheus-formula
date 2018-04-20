# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/haproxy/map.jinja" import prometheus_exporter_haproxy as prometheus with context %}

haproxy_exporter_service_unit:
  file.managed:
    - name: /etc/systemd/system/haproxy_exporter.service
    - source: salt://prometheus/exporter/haproxy/files/haproxy_exporter.systemd.jinja
    - template: jinja
    - watch:
      - file: haproxy_exporter_defaults
    - require_in:
      - file: haproxy_exporter_service

haproxy_exporter_service:
  service.running:
    - name: haproxy_exporter
    - enable: True
    - reload: True
    - watch:
      - file: haproxy_exporter_service_unit
      - file: haproxy_exporter_bin_link