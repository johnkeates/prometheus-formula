# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/node/map.jinja" import prometheus_exporter_node with context %}

create_prometheus_user:
  user.present:
    - name: {{ prometheus_exporter_node.exporter.node.user }}
    - home: {{ prometheus_exporter_node.exporter.node.home }}
    - createhome: False
    - system: True
    - fullname: "Prometheus daemon"