# -*- coding: utf-8 -*-
# vim: ft=sls

clear_exporter_grain:
  grains.absent:
    - name: prometheus_node_exporter
    - force: True

add_exporter_grain:
  grains.present:
    - name: prometheus_node_exporter
    - value: {{grains['ipv4'][0]}}:9100
    - force: True