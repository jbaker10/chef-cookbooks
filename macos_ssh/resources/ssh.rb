resource_name :ssh

SYSTEMSETUP_COMMAND = '/usr/sbin/systemsetup'.freeze
DSEDIT_COMMAND = '/usr/sbin/dseditgroup'.freeze
DSCL_COMMAND = '/usr/bin/dscl'.freeze

property :access_groups, Array
property :access_users, Array

action :activate do
  execute SYSTEMSETUP_COMMAND do
    command "#{SYSTEMSETUP_COMMAND} -setremotelogin on"
    not_if "`ssh_status=$(#{SYSTEMSETUP_COMMAND} -getremotelogin); if [[ $ssh_status == *'On'* ]]; then echo true; else echo false; fi`"
    guard_interpreter :bash
  end
end

action :deactivate do
  execute SYSTEMSETUP_COMMAND do
    command "#{SYSTEMSETUP_COMMAND} -setremotelogin off"
    not_if "`ssh_status=$(#{SYSTEMSETUP_COMMAND} -getremotelogin); if [[ $ssh_status == *'Off'* ]]; then echo true; else echo false; fi`"
    guard_interpreter :bash
  end
end

action :configure do
  if new_resource.access_groups || new_resource.access_users
    if new_resource.access_groups
      if new_resource.access_groups.length > 0
        execute "Create SSH Group" do
          command " #{DSEDIT_COMMAND} -o create -q com.apple.access_ssh"
          only_if "`ssh_group=$(#{DSEDIT_COMMAND} -o read -t group com.apple.access_ssh 2>&1); if [[ $ssh_group == *'Group not found.'* ]]; then echo true; else echo false; fi`"
          guard_interpreter :bash
        end
        i = 0
        while i < new_resource.access_groups.length
          execute "Add Groups to SSH Access Group" do
            current_groups = `#{DSCL_COMMAND} . -read /Groups/com.apple.access_ssh NestedGroups`
            group_gid = `#{DSCL_COMMAND} . -read /Groups/#{new_resource.access_groups[i]} GeneratedUID`.split(' ')[1]
            command "#{DSEDIT_COMMAND} -o edit -a #{new_resource.access_groups[i]} -t group com.apple.access_ssh"
            not_if "`if [[ '#{current_groups}' == *'#{group_gid}'* ]]; then echo true; else echo false; fi`"
            guard_interpreter :bash
          end
          i += 1
        end
      end
    end
    if new_resource.access_users
      if new_resource.access_users.length > 0
        execute "Create SSH Group" do
          command " #{DSEDIT_COMMAND} -o create -q com.apple.access_ssh"
          only_if "`ssh_group=$(#{DSEDIT_COMMAND} -o read -t group com.apple.access_ssh 2>&1); if [[ $ssh_group == *'Group not found.'* ]]; then echo true; else echo false; fi`"
          guard_interpreter :bash
        end
        i = 0
        while i < new_resource.access_users.length
          execute "Add Users to SSH Access Group" do
            command "#{DSEDIT_COMMAND} -o edit -a #{new_resource.access_users[i]} -t user com.apple.access_ssh"
            current_users = `#{DSCL_COMMAND} . -read /Groups/com.apple.access_ssh GroupMembership`
            command "#{DSEDIT_COMMAND} -o edit -a #{new_resource.access_users[i]} -t user com.apple.access_ssh"
            not_if "`if [[ '#{current_users}' == *'#{new_resource.access_users[i]}'* ]]; then echo true; else echo false; fi`"
            guard_interpreter :bash
          end
          i += 1
        end
      end
    end
  else
    execute "Delete SSH Group" do
      command " #{DSEDIT_COMMAND} -o delete -q com.apple.access_ssh"
      not_if "`ssh_group=$(#{DSEDIT_COMMAND} -o read -t group com.apple.access_ssh 2>&1); if [[ $ssh_group == *'Group not found.'* ]]; then echo true; else echo false; fi`"
      guard_interpreter :bash
    end
  end
end
