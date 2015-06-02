#
# Cookbook Name:: cdh5-pseudo
# Recipe:: spark
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{spark-core spark-history-server spark-python}.each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file '/etc/spark/conf/spark-env.sh' do
  source "spark-env.sh"
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/spark/conf/spark-defaults.conf' do
  source "spark-defaults.conf"
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

bash 'create spark history directory' do
  user 'hdfs'
  code <<-EOH
  hadoop fs -chown -R spark:spark /user/spark
  hadoop fs -chmod 1777 /user/spark/applicationHistory
  EOH
end

bash 'copy spark assembly jar to hdfs' do
  user 'spark'
  code <<-EOH
  hadoop fs -mkdir -p /user/spark/share/lib
  hadoop fs -put /usr/lib/spark/assembly/lib//spark-assembly.jar  /user/spark/share/lib/spark-assembly.jar
  EOH
  not_if 'hadoop fs -ls /user/spark/share/lib/spark-assembly.jar'
end

cookbook_file '/etc/hadoop/conf/yarn-site.xml' do
  source 'yarn-site.xml'
  owner 'root'
  group 'root'
  mode 0755
  action :create
  notifies :restart, 'service[hadoop-yarn-nodemanager]'
end

service 'hadoop-yarn-nodemanager' do
  action :nothing
  supports :restart => true
end

service 'spark-history-server' do
  action [:enable, :start]
end
