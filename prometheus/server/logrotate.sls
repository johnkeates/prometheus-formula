/var/log/prometheus/prometheus.log {
    weekly
    rotate 10
    copytruncate
    compress
    delaycompress
    notifempty
    missingok
}