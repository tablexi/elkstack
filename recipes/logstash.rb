# Encoding: utf-8
#
# Cookbook Name:: elkstack
# Recipe:: logstash
#
# Copyright 2014, Rackspace
#

# base stack requirements
include_recipe 'elkstack::_base'

logstash_instance 'server' do
  action 'create'
end

logstash_service 'server' do
  action :enable
end

my_templates = {
  'input_syslog' => 'config/input_syslog.conf.erb',
  'output_stdout' => 'config/output_stdout.conf.erb',
  'output_elasticsearch' => 'config/output_elasticsearch.conf.erb'
}

logstash_config 'server' do
  action 'create'
  templates my_templates
  templates_cookbook 'elkstack'
  # don't need notifies since the LWRP does it
end

logstash_service 'server' do
  action :start
end

include_recipe 'elkstack::logstash_monitoring'
