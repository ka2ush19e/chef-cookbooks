#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
include_recipe "elasticsearch::yum_repo"
include_recipe "elasticsearch::elasticsearch"
include_recipe "elasticsearch::plugins"
