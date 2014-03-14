#
# Cookbook Name:: network-tools
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{
  lsof
  iptables
  jwhois
  curl
  wget
  rsync
  nmap
  traceroute
  ethtool
  iproute
  iputils
  nc
  tcputils
  tcpdump
  elinks
  lynx
}.each do |pkg|
  package pkg do
    action :install
  end
end
