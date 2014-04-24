#
# Cookbook Name:: cdh4-pseudo
# Recipe:: hive
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{
  hive
  hive-metastore
  hive-server2
}.each do |pkg|
  package pkg do
    action :install
  end
end

bash "chmod for hive" do
  user   "hdfs"
  code <<-EOH
  hadoop fs -chmod -R 1777 /user
  EOH
end

sudo -u hdfs hadoop dfs -chmod 777 /user
