# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/node/map.jinja" import prometheus_exporter_node with context %}

# This file doesn't really do anything at this time

# prometheus_exporter_node_defaults_config:
#   file.managed:
#     - name: {{ prometheus_exporter_node.exporter.node.defaults_file }}
#     - user: {{ prometheus_exporter_node.exporter.node.user }}
#     - group: {{ prometheus_exporter_node.exporter.node.group }}
#     - source: prometheus/exporter/node/files/node_exporter.defaults.jinja
#     - dataset_pillar: prometheus_exporter_node:exporter:node:args