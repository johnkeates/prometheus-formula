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


# Create target file if none exists
prometheus_storage_targets_safety_preset:
  file.managed:
    - name: {{ prometheus.server.discovery.file.target_file }}
    - source: salt://prometheus/server/files/sd/failsafe.json
    - unless: test -e {{ prometheus.server.discovery.file.target_file }}