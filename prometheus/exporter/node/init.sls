# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  # Downloads and expands a specific version of the node.exporter component
  - prometheus.exporter.node.install

  # Configures the YML and Defaults as well as any missing directories
  - prometheus.exporter.node.config

  # Add user required to run the service
  - prometheus.exporter.node.user

  # Manages startup scripts and files and starts/stops the service as required
  - prometheus.exporter.node.service

  # Sets a grain to expose this to the scraping server
  - prometheus.exporter.node.grain
