require 'puma/daemon'
bind 'tcp://0.0.0.0:80'
workers 2
threads 4
daemonize