**************************
Conreality Master Firmware
**************************

.. image:: https://img.shields.io/badge/license-Public%20Domain-blue.svg
   :alt: Project license
   :target: https://unlicense.org

.. image:: https://img.shields.io/travis/conreality/conreality-master/master.svg
   :alt: Travis CI build status
   :target: https://travis-ci.org/conreality/conreality-master

|

https://wiki.conreality.org/Master

Prerequisites
=============

Build Prerequisites
-------------------

- `Docker <https://www.docker.com/community-edition>`__ (for testing)
- `GNU Make <https://www.gnu.org/software/make/>`__ (for builds)

Features
========

Network Services
----------------

- SSH server (``dropbear``) listening on exposed TCP port 22.
- mDNS server (``avahi-daemon``) listening on UDP port 5353.
- FreeSWITCH server (``freeswitch``) listening on exposed TCP ports 5060,
  5080, and 8021, as well as UDP ports 16384-16484.
- PostgreSQL server (``postgres``) listening on exposed TCP port 5432.

Installed Software
------------------

System Daemons
^^^^^^^^^^^^^^

- Avahi 0.6.32
- D-Bus 1.10.24
- Dnsmasq 2.78
- Dropbear 2017.75
- FreeSWITCH 1.6.19
- PostgreSQL 10.2
- s6 2.7.0

Language Runtimes
^^^^^^^^^^^^^^^^^

- Erlang 20.2.4
- libstdc++ 6.4.0
- Lua 5.3.4
- PL/Lua 1.1+

Utility Libraries
^^^^^^^^^^^^^^^^^

- PostGIS 2.4+

Miscellaneous
^^^^^^^^^^^^^

See the `base image <https://github.com/conreality/conreality-docker>`__
for the full list of included software.

Configuration
-------------

- The time zone is UTC (``TZ=UTC``), the locale is UTF-8
  (``LANG=en_US.UTF-8``).

- Services are managed by s6 in ``/etc/s6/services``.

See Also
========

- `Conreality Development Environment
  <https://github.com/conreality/conreality-devbox>`__

- `Conreality Docker Image
  <https://github.com/conreality/conreality-docker>`__

- `Conreality Slave Firmware
  <https://github.com/conreality/conreality-slave>`__
