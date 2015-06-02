#
# Cookbook Name:: cdh5-pseudo
# Recipe:: yum_repo
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum'

yum_repository 'cloudera-cdh5' do
  description "Cloudera's Distribution for Hadoop, Version 5"
  baseurl 'http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5.4.2/'
  gpgkey 'http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera'
  gpgcheck true
  action :create
end

