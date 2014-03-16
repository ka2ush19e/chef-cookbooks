#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("rhel")
  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node.timezone}"
  end
end
