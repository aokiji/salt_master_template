create redmine data directory:
  file.directory:
    - name: /var/data/redmine/files
    - makedirs: True

create postgres data directory:
  file.directory:
    - name: /var/data/redmine/pgdata
    - makedirs: True

/var/lib/redmine/redmine.yml:
  file.managed:
    - source: salt://data/redmine/docker-compose.yml
    - template: jinja
    - defaults:
      port: {{ pillar['redmine']['port'] }}
    - makedirs: True
    - watch_in:
      - service: redmine

/var/lib/redmine/database.yml:
  file.managed:
    - source: salt://data/redmine/database.yml
    - makedirs: True
    - watch_in:
      - service: redmine

/var/lib/redmine/Dockerfile:
  file.managed:
    - source: salt://data/redmine/Dockerfile
    - makedirs: True
    - watch_in:
      - service: redmine

/etc/systemd/system/jenkins.service:
  file.managed:
    - source: salt://data/docker/docker.service
    - template: jinja
  - defaults:
    service_name: redmine
    service_description: Redmine
  - watch_in:
    - service: redmine

/etc/nginx/conf.d/redmine.conf:
  file.managed:
    - source: salt://data/reverse_proxy/redmine.conf
    - makedirs: True
    - template: jinja
    - defaults:
      domain_name: {{ pillar['domain_name'] }}
      redmine_port: {{ pillar['redmine']['port'] }}
    - watch_in:
      - service: nginx

/etc/pki/redmine.crt:
  file.managed:
    - source: salt://data/reverse_proxy/redmine.crt
    - makedirs: True
    - watch_in:
      - service: nginx

/etc/pki/redmine.key:
  file.managed:
    - source: salt://data/reverse_proxy/redmine.key
    - makedirs: True
    - watch_in:
      - service: nginx

start redmine service:
  service.running:
    - name: redmine
    - enable: True
