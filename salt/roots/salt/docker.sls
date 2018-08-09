install docker package:               
  pkg.installed:
    - pkgs:
      - docker
      - python-pip
      
install docker-compose:
  pip.installed:
    - name: docker-compose == 1.4.0

start docker service:
  service.running:
    - name: docker
    - enable: True
