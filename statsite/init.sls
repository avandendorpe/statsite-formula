{% from "statsite/map.jinja" import statsite with context -%}
statsite:
  user.present:
    - name: {{ statsite.user }}
    - createhome: false
    - shell: /bin/bash
    - empty_password: true
    - system: true
  pkg.installed:
    - sources:
      - {{ statsite.pkg_name }}: {{ statsite.pkg_source }}

statsite-config:
  file.managed:
    - name: {{ statsite.conf_dir }}/statsite.ini
    - source: salt://statsite/templates/statsite.ini.jinja
    - template: jinja
    - user: {{ statsite.user }}
    - group: {{ statsite.group }}
    - mode: 644
    - makedirs: True