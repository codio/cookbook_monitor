Sensu Monitoring Chef Cookbook
==============================

Monitor is a cookbook for monitoring services, using Sensu, a monitoring framework. The default
recipe installs & configures the Sensu client (monitoring agent), as well as common service check
dependencies. The master recipe installs & configures the Sensu server, API, dashboard, & their
dependencies (eg. RabbitMQ & Redis). The remaining recipes are intended to put monitoring checks in
place in order to monitor specific services (eg. `recipe[monitor::redis]`).

Learn more about Sensu [Here](http://docs.sensuapp.org/).


## Requirements

The [Sensu cookbook](http://community.opscode.com/cookbooks/sensu).


## Attributes

`node["monitor"]["master_address"]` - Bypass the chef node search and explicitly set the address to
reach the master server.

`node["monitor"]["environment_aware_search"]` - Defaults to false. If true, will limit search to the
node's chef_environment.

`node["monitor"]["use_local_ipv4"]` - Defaults to false. If true, use cloud local\_ipv4 when
available instead of public\_ipv4.

`node["monitor"]["sensu_plugin_version"]` - Sensu Plugin library version.

`node["monitor"]["additional_client_attributes"]` - Additional client attributes to be passed to the
sensu_client LWRP.

`node["monitor"]["default_handlers"]` - Default event handlers.

`node["monitor"]["metric_handlers"]` - Metric event handlers.


## Usage

Example: To monitor the Redis service running on a Chef node, include `recipe[monitor::redis]` in
its run list.


## Development

Cookbooks are strictly versioned, and the Chef server will lock and freeze each cookbook you upload.
This means that unless you bump the version number of the cookbook, the Chef server will not update
it when you upload.

All Codio servers belong to a Chef role and environment, and each environment *MUST* specify the
version which that environment will use. This protects that environment against new cookbooks
that may not yet be ready. Once they are ready, a simple edit of the environment will suffice.

In order to develop and test new cookbook versions, you will need to bump the version of the
cookbook just the once, and then upload that. Because the production environment uses specific
cookbook versions, you are safe to upload new version(s) and test these before eventually promoting
your new version to production.

Wherever possible, cookbooks should first be tested locally using Vagrant, and development should
take place in a branch. The cookbook minor version number should be incremented to ensure safe usage
of the Cookbook.