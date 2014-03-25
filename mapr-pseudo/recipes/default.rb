#
# Cookbook Name:: mapr-pseudo
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mapr-pseudo::user"
include_recipe "mapr-pseudo::ulimit"
include_recipe "mapr-pseudo::sysctl"

include_recipe "mapr-pseudo::yum_repo"
# include_recipe "mapr-pseudo::mapr"
