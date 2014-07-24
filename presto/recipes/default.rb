#
# Cookbook Name:: presto
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "presto::user"
include_recipe "presto::java"
include_recipe "presto::hive"
include_recipe "presto::presto"
