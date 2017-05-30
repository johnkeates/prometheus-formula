# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}

prometheus_server_config:
  file.serialize:
    - name: {{ prometheus.server.args.config_file }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - dataset_pillar: prometheus:server:config