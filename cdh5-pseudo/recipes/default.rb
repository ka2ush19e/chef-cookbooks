#
# Cookbook Name:: cdh5-pseudo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cdh5-pseudo::iptables'
include_recipe 'cdh5-pseudo::java'
include_recipe 'cdh5-pseudo::yum_repo'
include_recipe 'cdh5-pseudo::hadoop'
include_recipe 'cdh5-pseudo::hadoop_hdfs_users'
