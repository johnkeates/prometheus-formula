# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/haproxy/map.jinja" import prometheus_exporter_haproxy with context %}

create_prometheus_user:
  user.present:
    - name: {{ prometheus_exporter_haproxy.exporter.haproxy.user }}
    - home: {{ prometheus_exporter_haproxy.exporter.haproxy.home }}
    - createhome: False
    - system: True
    - fullname: "Prometheus daemon"