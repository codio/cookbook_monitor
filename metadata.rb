name             "monitor"
maintainer       "Sean Porter Consulting"
maintainer_email "portertech@gmail.com"
license          "Apache 2.0"
description      "A cookbook for monitoring services, using Sensu, a monitoring framework."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.4"

supports 'ubuntu'

depends 'apt'
depends 'sensu', '>= 0.8'
depends 'sudo'
depends 'python'
depends 'logrotate'
depends 'graphite'
depends 'haproxy'