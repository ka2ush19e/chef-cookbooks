#
# Cookbook Name:: presto
# Recipe:: hive
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

%w{
  hive-metastore
}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{
  mysql-server
  mysql-connector-java
}.each do |pkg|
  package pkg do
    action :install
  end
end

java_alternatives "set java alternatives" do
  java_location "/usr/lib/jvm/java-1.7.0/bin/java"
  action :set
end

link "/usr/lib/hive/lib/mysql-connector-java.jar" do
  to "/usr/share/java/mysql-connector-java.jar"
end

service "mysqld" do
  action [:enable, :start]
end

root_password = node.hive[:db][:root][:password]
execute "secure_install" do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/secure_install.sql"
  action  :nothing
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

template "#{Chef::Config[:file_cache_path]}/secure_install.sql" do
  source   "secure_install.sql.erb"
  owner    "root"
  group    "root"
  mode     0644
  notifies :run, "execute[secure_install]", :immediately
end

hive_password = node.hive[:db][:hive][:password]
execute "hive_metastore" do
  command "/usr/bin/mysql -u root -p#{root_password} < #{Chef::Config[:file_cache_path]}/hive_metastore.sql"
  action  :nothing
end

template "#{Chef::Config[:file_cache_path]}/hive_metastore.sql" do
  source   "hive_metastore.sql.erb"
  owner    "root"
  group    "root"
  mode     0644
  notifies :run, "execute[hive_metastore]", :immediately
end

template "/etc/hive/conf/hive-site.xml" do
  source "hive-site.xml.erb"
  owner  "root"
  group  "root"
  mode   0644
end

service "hive-metastore" do
  action [:enable, :start]
end
