# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/haproxy/map.jinja" import prometheus_exporter_haproxy with context %}

# This file doesn't really do anything at this time

# prometheus_exporter_haproxy_defaults_config:
#   file.managed:
#     - name: {{ prometheus_exporter_haproxy.exporter.haproxy.defaults_file }}
#     - user: {{ prometheus_exporter_haproxy.exporter.haproxy.user }}
#     - group: {{ prometheus_exporter_haproxy.exporter.haproxy.group }}
#     - source: prometheus/exporter/haproxy/files/haproxy_exporter.defaults.jinja
#     - dataset_pillar: prometheus_exporter_haproxy:exporter:haproxy:args