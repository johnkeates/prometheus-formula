# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  # Downloads and expands a specific version of the node.exporter component
  - prometheus.node.exporter.install

  # Configures the YML and Defaults as well as any missing directories
  - prometheus.node.exporter.config

  # Manages startup scripts and files and starts/stops the service as required
  - prometheus.node.exporter.service
