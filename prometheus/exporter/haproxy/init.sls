# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  # Downloads and expands a specific version of the haproxy.exporter component
  - prometheus.exporter.haproxy.install

  # Configures the YML and Defaults as well as any missing directories
  - prometheus.exporter.haproxy.config

  # Add user required to run the service
  - prometheus.exporter.haproxy.user

  # Manages startup scripts and files and starts/stops the service as required
  - prometheus.exporter.haproxy.service

  # Sets a grain to expose this to the scraping server
  - prometheus.exporter.haproxy.grain
