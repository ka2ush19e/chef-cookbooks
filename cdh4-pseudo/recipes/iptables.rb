#
# Cookbook Name:: cdh4-pseudo
# Recipe:: iptables
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{iptables ip6tables}.each do |pkg|
  service pkg do
    action [:stop, :disable]
  end
end
