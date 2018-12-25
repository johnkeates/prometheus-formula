# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "prometheus/exporter/node/map.jinja" import prometheus_exporter_node with context %}
{% if salt['pillar.get']('prometheus:exporter:node:enable_mine_registration', True) %}

add_exporter_grain:
  grains.present:
    - name: prometheus_node_exporter
    - value: {{grains['ipv4'][0]}}:9100
    - force: True

{% else %}

clear_exporter_grain:
  grains.absent:
    - name: prometheus_node_exporter
    - destructive: True
    - force: True

{% endif %}