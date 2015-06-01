#
# Cookbook Name:: cdh5-pseudo
# Recipe:: iptables
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{iptables ip6tables}.each do |pkg|
  service pkg do
    action [:stop, :disable]
  end
end
