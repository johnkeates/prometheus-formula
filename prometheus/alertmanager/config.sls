# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/alertmanager/map.jinja" import alertmanager_server with context %}
{% from "prometheus/server/map.jinja" import prometheus_server with context %}


alertmanager_server_config:
  file.serialize:
    - name: {{ alertmanager_server.alertmanager.args.config_file }}
    - user: {{ prometheus_server.user }}
    - group: {{ prometheus_server.group }}
    - dataset_pillar: prometheus:alertmanager:config