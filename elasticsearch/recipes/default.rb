#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum"

yum_repository "elasticsearch-1.0" do
  description "Elasticsearch repository for 1.0.x packages"
  baseurl     "http://packages.elasticsearch.org/elasticsearch/1.0/centos/"
  gpgkey      "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"
  gpgcheck    true
  action      :create
end

package "elasticsearch" do
  action :install
end

service "elasticsearch" do
  action :enable
end
