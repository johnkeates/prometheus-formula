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


    #   version: 0.14.0.linux-amd64
    #   install_dir: /opt
    #   source: https://github.com/prometheus/node_exporter/releases/download/v0.14.0/node_exporter-0.14.0.linux-amd64.tar.gz
    #   source_hash: sha256=d5980bf5d0dc7214741b65d3771f08e6f8311c86531ae21c6ffec1d643549b2e
    # haproxy:
    #   version: 0.7.1.linux-amd64
    #   install_dir: /opt
    #   source: https://github.com/prometheus/haproxy_exporter/releases/download/v0.7.1/haproxy_exporter-0.7.1.linux-amd64.tar.gz
    #   source_hash: sha1=56849253e280db3db2aa80f1013ecfe242536d32
    #   args:
    #     scrape_uri: 'unix:/run/haproxy/admin.sock'