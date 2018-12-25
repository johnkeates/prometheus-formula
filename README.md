prometheus-formula
==================

This formula is a compound of multiple common prometheus components:

- prometheus, the server component itself
- alertmanager
- pushgateway
- node_exporter
- haproxy_exporter

Currently, this is the best way to deduplicate common configuration and demo the exporters. At some point in the future when complexity or coupling is too much it might be helpful to start maintaining components in their own spun-off repositories.


note:

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`

Organisation
============

Top level, we have the server, alertmanager and pushgateway as self-contained components as well as a common map and defaults file. The users state is also shared at this level.

Inside the exporter directory we have the exporters themselves. While the binaries are named $type_exporter by convention, we refer to them the other way around in Salt, i.e. prometheus.expoter.node and prometheus.exporter.haproxy as to namespace all the expoters below a single key.

For the components, a defaults and versions file keeps track of the normal setup, while in the states both the specific map and the global map is loaded as to allow for central default setup as wel as local overrides per component.

Variables flow from global/common to local to pillar, whichever is last overrides the rest.

Available states
================

``prometheus.server``
------------

Installs the prometheus package, and starts the associated prometheus service.

``prometheus.alertmanager``
------------

Installs the alertmanager package, and starts the associated alertmanager service.

``prometheus.pushgateway``
------------

Installs the pushgateway package, and starts the associated pushgateway service.

``prometheus.exporter.node``
------------

Installs the node_exporter package, and starts the associated node_exporter service.

``prometheus.exporter.haproxy``
------------

Installs the haproxy_exporter package, and starts the associated haproxy_exporter service.
