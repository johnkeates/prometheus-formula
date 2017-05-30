# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}

prometheus_service_unit:
  file.managed:
{%- if grains.get('init') == 'systemd' %}
    - name: /etc/systemd/system/prometheus.service
    - source: salt://prometheus/files/prometheus.systemd.jinja
{%- elif grains.get('init') == 'upstart' %}
    - name: /etc/init/prometheus.conf
    - source: salt://prometheus/files/prometheus.upstart.jinja
{%- endif %}
    - watch:
      - file: prometheus_defaults
    - require_in:
      - file: prometheus_service

prometheus_service:
  service.running:
    - name: prometheus
    - enable: True
    - reload: True
    - watch:
      - file: prometheus_service_unit
      - file: prometheus_server_config
      - file: prometheus_bin_link