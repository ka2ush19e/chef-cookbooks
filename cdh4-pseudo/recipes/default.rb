#
# Cookbook Name:: cdh4-pseudo
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "cdh4-pseudo::iptables"
include_recipe "cdh4-pseudo::yum_repo"
include_recipe "cdh4-pseudo::hadoop"
