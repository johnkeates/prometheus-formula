# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/alertmanager/map.jinja" import alertmanager_server with context %}

alertmanager_service_unit:
  file.managed:
{%- if grains.get('init') == 'systemd' %}
    - name: /etc/systemd/system/alertmanager.service
    - source: salt://alertmanager/files/alertmanager.systemd.jinja
{%- elif grains.get('init') == 'upstart' %}
    - name: /etc/init/alertmanager.conf
    - source: salt://alertmanager/files/alertmanager.upstart.jinja
{%- endif %}
    - watch:
      - file: prometheus_defaults
    - require_in:
      - file: prometheus_service

alertmanager_service:
  service.running:
    - name: alertmanager
    - enable: True
    - reload: True
    - watch:
      - file: alertmanager_service_unit
      - file: alertmanager_server_config
      - file: alertmanager_bin_link