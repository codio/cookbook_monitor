override["sensu"]["use_embedded_ruby"] = true
override["sensu"]["version"] = "0.12.6-2"

default["monitor"]["master_address"] = nil

default["monitor"]["environment_aware_search"] = false
default["monitor"]["use_local_ipv4"] = false

default["monitor"]["additional_client_attributes"] = Mash.new

default["monitor"]["use_nagios_plugins"] = false
default["monitor"]["use_system_profile"] = false
default["monitor"]["use_statsd_input"] = false

default["monitor"]["sudo_commands"] = Array.new

default["monitor"]["default_handlers"] = ["debug", "mailer", "twiliosms"]
default["monitor"]["metric_handlers"] = ["debug"]

default["monitor"]["client_extension_dir"] = "/etc/sensu/extensions/client"
default["monitor"]["server_extension_dir"] = "/etc/sensu/extensions/server"

# Checks
default["monitor"]["checks"] = {
  "system_cpu" => {
    "enabled" => true,
    "occurrences" => 10,
    "command_options" => ""
  },
  "system_load" => {
    "enabled" => true,
    "occurrences" => 1,
    "command_options" => ""
  },
  "system_disk" => {
    "enabled" => true,
    "occurrences" => 1,
    "command_options" => ""
  },
  "system_ram" => {
    "enabled" => true,
    "occurrences" => 2,
    "command_options" => ""
  }
}
