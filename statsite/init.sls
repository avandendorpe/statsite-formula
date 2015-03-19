{% from "statsite/map.jinja" import statsite with context -%}
statsite:
  user.present:
    - name: {{ statsite.user }}
    - createhome: false
    - shell: /bin/bash
    - empty_password: true
    - system: true
  pkg.installed:
    - name: {{ statsite.pkg_name }}
    - source: {{ statsite.pkg_source }}

statsite-config:
  file.managed:
    - name: {{ statsite.conf_dir }}/statsite.ini
    - source: salt://statsite/templates/statsite.ini.jinja
    - template: jinja
    - user: {{ statsite.user }}
    - group: {{ statsite.group }}
    - mode: 644
    - makedirs: True

statsite-init:
  file.managed:
    - name: /etc/init/statsite.conf
    - source: salt://statsite/templates/init.jinja
    - template: jinja
    - context:
      user: {{ statsite.user }}
      group: {{ statsite.group }}
      conf_dir: {{ statsite.conf_dir }}
      install_dir: {{ statsite.install_dir }}