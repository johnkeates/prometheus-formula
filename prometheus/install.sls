# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "prometheus/map.jinja" import prometheus with context %}

prometheus-pkg:
  pkg.installed:
    - name: {{ prometheus.pkg }}
