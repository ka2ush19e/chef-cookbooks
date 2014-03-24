#
# Cookbook Name:: network-tools
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:network_tools].each do |pkg|
  package pkg do
    action :install
  end
end
