# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "prometheus/exporter/node/map.jinja" import prometheus_exporter_node with context %}

{% set version_path = prometheus_exporter_node.exporter.node.install_dir + prometheus_exporter_node.exporter.node.exporter_node_version_id + "/" %}

# Download the tarball
node_exporter_tarball:
  archive.extracted:
    - name: {{ version_path }}
    - source: {{ prometheus_exporter_node.exporter.node.exporter_node_version_source }}
    - source_hash: {{ prometheus_exporter_node.exporter.node.exporter_node_version_source_hash }}
    - archive_format: tar
    - if_missing: {{ version_path }}

# Link the extracted binary to the system path
node_exporter_bin_link:
  file.symlink:
    - name: /usr/bin/node_exporter
    - target: {{ version_path }}node_exporter-{{ prometheus_exporter_node.exporter.node.exporter_node_version_id }}/node_exporter
    - require:
      - archive: node_exporter_tarball

# Setup startup settings
node_exporter_defaults:
  file.managed:
    - name: {{ prometheus_exporter_node.exporter.node.defaults_file }}
    - source: salt://prometheus/exporter/node/files/node_exporter.defaults.jinja
    - template: jinja
    - dataset_pillar: prometheus_exporter_node:exporter:node:args