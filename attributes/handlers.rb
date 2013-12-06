default[:monitor][:pagerduty_api_key] = ""

default[:monitor][:graphite_address] = nil
default[:monitor][:graphite_port] = nil

# Mailer recipients
default[:monitor][:mailer][:recipients] = %w( jmoss@codio.com mkraev@codio.com )
default[:monitor][:mailer][:from] = 'sensu@codio.com'
default[:monitor][:mailer][:smtp_address] = 'smtp.mandrillapp.com'
default[:monitor][:mailer][:smtp_port] = 587
default[:monitor][:mailer][:smtp_domain] = 'codio.com'
