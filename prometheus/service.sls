# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "prometheus/map.jinja" import prometheus with context %}

prometheus-name:
  service.running:
    - name: {{ prometheus.service.name }}
    - enable: True
