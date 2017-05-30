# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "prometheus/map.jinja" import prometheus with context %}

prometheus-config:
  file.managed:
    - name: {{ prometheus.config }}
    - source: salt://prometheus/files/example.tmpl
    - mode: 644
    - user: root
    - group: root
