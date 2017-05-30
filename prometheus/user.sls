# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "prometheus/map.jinja" import prometheus with context %}

prometheus_group:
  group.present:
    - name: {{ prometheus.group }}
    - system: True

prometheus_user:
  user.present:
    - name: {{ prometheus.user }}
    - home: {{ prometheus.home }}
    - gid: {{ prometheus.group }}
    - system: True