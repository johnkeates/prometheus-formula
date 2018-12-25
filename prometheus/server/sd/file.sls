{% from "prometheus/server/map.jinja" import prometheus_server as prometheus with context %}

# Configure path for target storage
{%- if prometheus.server.args.storage.targets is defined %}
prometheus_storage_targets_path:
  file.directory:
    - name: {{ prometheus.server.args.storage.targets }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - makedirs: True
{%- endif %}

prometheus_file_based_service_discovery:
  file.managed:
    - name: {{ prometheus.server.discovery.file.target_file }}
    - user: {{ prometheus.user }}
    - group: {{ prometheus.group }}
    - source: salt://prometheus/server/files/sd/targets.j2
    - template: jinja

# Create target file if none exists
prometheus_storage_targets_safety_preset:
  file.managed:
    - name: {{ prometheus.server.discovery.file.target_file }}
    - source: salt://prometheus/server/files/sd/failsafe.json
    - unless: test -f {{ prometheus.server.discovery.file.target_file }}

# This reload is needed in cases where prometheus was started without the directory structure or file being there; it might not receive inotify/fsevents.
prometheus_storage_targets_safety_preset_reload_changes:    
  service.running:
    - name: prometheus
    - reload: True
    - watch:
      - prometheus_storage_targets_safety_preset
      - prometheus_file_based_service_discovery

# this needs a minion modifier?
# mine_functions:
#   prometheus_node_exporter:
#     - mine_function: grains.get
#     - prometheus_node_exporter