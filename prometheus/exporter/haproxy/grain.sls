# -*- coding: utf-8 -*-
# vim: ft=sls

clear_haproxy_exporter_grain:
  grains.absent:
    - name: prometheus_haproxy_exporter
    - force: True

add_haproxy_exporter_grain:
  grains.present:
    - name: prometheus_haproxy_exporter
    - value: {{grains['ipv4'][0]}}:9100
    - force: True