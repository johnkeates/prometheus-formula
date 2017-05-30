# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/map.jinja" import prometheus with context %}

pushgateway_service_unit:
  file.managed:
{%- if grains.get('init') == 'systemd' %}
    - name: /etc/systemd/system/pushgateway.service
    - source: salt://prometheus/pushgateway/files/pushgateway.systemd.jinja
{%- elif grains.get('init') == 'upstart' %}
    - name: /etc/init/pushgateway.conf
    - source: salt://prometheus/pushgateway/files/pushgateway.upstart.jinja
{%- endif %}
    - watch:
      - file: pushgateway_defaults
    - require_in:
      - file: pushgateway_service

pushgateway_service:
  service.running:
    - name: pushgateway
    - enable: True
    - reload: True
    - watch:
      - file: pushgateway_service_unit
      - file: pushgateway_server_config
      - file: pushgateway_bin_link