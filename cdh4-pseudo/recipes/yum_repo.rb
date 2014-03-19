#
# Cookbook Name:: cdh4-pseudo
# Recipe:: yum_repo
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum"

yum_repository "cloudera-cdh4" do
  description "Cloudera's Distribution for Hadoop, Version 4"
  baseurl     "http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/4/"
  gpgkey      "http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  gpgcheck    true
  action      :create
end
