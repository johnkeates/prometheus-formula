# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/server/map.jinja" import prometheus_server as prometheus with context %}

create_prometheus_user:
  user.present:
    - name: {{ prometheus_exporter_node.user }}
    - home: {{ prometheus_exporter_node.home }}
    - createhome: False
    - system: True
    - fullname: "Prometheus daemon"