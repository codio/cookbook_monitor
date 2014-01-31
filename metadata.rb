name             "monitor"
maintainer       "Sean Porter Consulting"
maintainer_email "portertech@gmail.com"
license          "Apache 2.0"
description      "A cookbook for monitoring services, using Sensu, a monitoring framework."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
<<<<<<< HEAD
version          "0.11.1"
=======
version          "0.4.0"

supports 'ubuntu'
>>>>>>> System checks now use attributes for occurrences

depends 'apt'
depends 'sensu', '>= 0.8'
depends 'sudo'
depends 'python'
depends 'logrotate'
depends 'graphite'
depends 'haproxy'
