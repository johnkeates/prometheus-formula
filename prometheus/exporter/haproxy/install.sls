# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/haproxy/map.jinja" import prometheus_exporter_haproxy with context %}

{% set version_path = prometheus_exporter_haproxy.exporter.haproxy.install_dir + prometheus_exporter_haproxy.exporter.haproxy.exporter_haproxy_version_id + "/" %}

# Download the tarball
haproxy_exporter_tarball:
  archive.extracted:
    - name: {{ version_path }}
    - source: {{ prometheus_exporter_haproxy.exporter.haproxy.exporter_haproxy_version_source }}
    - source_hash: {{ prometheus_exporter_haproxy.exporter.haproxy.exporter_haproxy_version_source_hash }}
    - archive_format: tar
    - if_missing: {{ version_path }}

# Link the extracted binary to the system path
haproxy_exporter_bin_link:
  file.symlink:
    - name: /usr/bin/haproxy_exporter
    - target: {{ version_path }}haproxy_exporter-{{ prometheus_exporter_haproxy.exporter.haproxy.exporter_haproxy_version_id }}/haproxy_exporter
    - require:
      - archive: haproxy_exporter_tarball

# Setup startup settings
haproxy_exporter_defaults:
  file.managed:
    - name: {{ prometheus_exporter_haproxy.exporter.haproxy.defaults_file }}
    - source: salt://prometheus/exporter/haproxy/files/haproxy_exporter.defaults.jinja
    - template: jinja
    - dataset_pillar: prometheus_exporter_haproxy:exporter:haproxy:args