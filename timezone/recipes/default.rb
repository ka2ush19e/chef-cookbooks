#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "crond" do
  supports :restart => true
  action :nothing
end

if platform_family?("rhel")
  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node.timezone}"
    notifies :restart, "service[crond]"
  end
end
