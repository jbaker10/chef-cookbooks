#
# Cookbook:: macos_ssh
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

ssh 'activate and configure' do
  action [:activate, :configure]
  access_groups ['admin', 'powerusers']
end