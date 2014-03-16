#
# Cookbook Name:: hostname
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

hostname = node["set_hostname"]
execute "hostname #{hostname}"
ohai "reload"
