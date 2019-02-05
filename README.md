Ansible Role `pandorafms_console`
=========

An ansible role to install Pandora FMS console and do it's [initial configuration](https://wiki.pandorafms.com/index.php?title=Pandora:Documentation_en:Installing#Initial_Console_Configuration).

Requirements
------------

A running MySQL instance if you want to do initial configuration by this role.

Role Variables
--------------

Variable | Default | Description
---------|---------|------------
`pandorafms_console_version` | `null` | The version of the Pandora FMS console to install. When `null`, latest package on the repository will be installed.
`pandorafms_console_skip_initial_configuration` | `false` | When `true`, only pacage installation will be performed. 
`pandorafms_db_privileged_user_name` | 'root' | The name of the user with permission to create database and user
`pandorafms_db_privileged_user_password` | -  | The password of the user specified by `pandorafms_db_privileged_user_name`.
`pandorafms_dbhost`| 'localhost' | The IP address or hostname of the DB instance to create database for Pandora FMS.
`pandorafms_dbname`| 'pandora'   | The name of the Pandora FMS database.
`pandorafms_dbuser`| 'pandora'   | The username for the Pandora FMS database.
`pandorafms_dbpass`| 'pandora'   | The password of the `pandorafms_dbuser`
`pandorafms_dbport`| -           | The port number used for connecting to database.
`pandorafms_console_homeurl`        | '/pandora\_console' |
`pandorafms_console_homeurl_static` | '/pandora\_console' |
`pandorafms_console_web_service_enabled`| - | When set to `true` or `false`, web serivce (e.g. httpd on RedHat platform) will be enabled/diable.
`pandorafms_console_web_service_state`  | - | When set, state of web serivce (e.g. httpd on RedHat platform) will be changed to specified state.

Dependencies
------------

- rworksjp.repo-pandorafms

Example Playbook
----------------

```
# Only install package
- hosts: servers
  roles:
    - role: rworksjp.pandorafms_console
      pandorafms_console_skip_initial_configuration: yes

# Install Pandora FMS console 7.0NG.719, enable and start web service
- hosts: servers
  roles:
    - role: rworksjp.pandorafms_console
      pandorafms_console_version: 7.0NG.719
      pandorafms_console_web_service_enabled: true
      pandorafms_console_web_service_state: started
```

License
-------

BSD
