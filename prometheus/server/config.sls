# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/server/map.jinja" import prometheus_server as prometheus with context %}

prometheus_server_config:
  file.serialize:
    - makedirs: True
    - name: {{ prometheus.server.args.config_file }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - dataset_pillar: prometheus:server:config