#
# Cookbook Name:: hwdmediashare
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe "hwdmediashare::base"
include_recipe "hwdmediashare::apache"
include_recipe "hwdmediashare::mysql"
include_recipe "hwdmediashare::php"
include_recipe "hwdmediashare::mct"
include_recipe "hwdmediashare::adminer"
