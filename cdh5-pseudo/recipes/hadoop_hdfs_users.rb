#
# Cookbook Name:: cdh5-pseudo
# Recipe:: hadoop_hdfs_users
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node.has_key?('hadoop') && node['hadoop'].has_key?('users')
  node['hadoop']['users'].each do |user|
    bash 'create user directories' do
      user 'hdfs'
      code <<-EOH
      hadoop fs -mkdir /user/#{user}
      hadoop fs -chown #{user} /user/#{user}
      EOH
      not_if "hadoop fs -ls /user | grep #{user}"
    end
  end
end
