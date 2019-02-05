Ansible Role pandorafms\_console
=========

An ansible role to install Pandora FMS consloe and do it's initial configuration.

Requirements
------------

Running MySQL instance if you want to do initial configuration by this role.

Role Variables
--------------

variable | default | description
---------|---------|------------
pandorafms\_console\_version | `null` (install latest package from package repository) | The version of the Pandora FMS console to install.
pandorafms\_console\_do\_initial\_configuration | `no` | if set to `yes`, create database (if absent) and user for Pandora FMS on MySQL instance and generate config file of the Pandora FMS console
pandorafms\_console\_force\_init\_db | `no` | if set to `yes`, existence pandorafms database is dropped
pandorafms\_db\_privileged\_user\_name | root | The user name can create db and user
pandorafms\_db\_privileged\_user\_password | not defined | The password of the `pandorafms_db_privileged_user_name`
pandorafms\_dbhost| localhost | IP address or hostname which Pandora FMS database is FIXME:
pandorafms\_dbname| pandora | name of Pandora FMS database
pandorafms\_dbuser| pandora | The username used in the Pandora database connetion
pandorafms\_dbpass| pandora | The password of the `pandorafms_dbuser`
pandorafms\_dbport| not defined | The port number to used for db connection
pandorafms\_console\_homeurl | /pandora\_console |
pandorafms\_console\_homeurl\_static | /pandora\_console |

Dependencies
------------

- rworksjp.repo-pandorafms

Example Playbook
----------------

```
- hosts: servers
  roles:
    - role: rworksjp.pandorafms_console
      pandorafms_console_do_initial_setup: yes
```

License
-------

BSD
