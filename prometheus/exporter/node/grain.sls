# -*- coding: utf-8 -*-
# vim: ft=sls

add_exporter_grain:
  grains.present:
    - name: prometheus_node
    - value: exporter