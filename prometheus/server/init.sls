# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  # General state required by most prometheus components
  - prometheus.user

  # Downloads and expands a specific version of the server component
  - prometheus.server.install

  # Configures the YML and Defaults as well as any missing directories
  - prometheus.server.config

  # Manages startup scripts and files and starts/stops the service as required
  - prometheus.server.service
