resource_name :nessus_cli

NESSUSCLI_COMMAND = '/Library/NessusAgent/run/sbin/nessuscli'.freeze

## Properties for the 'link' command
property :key, String, required: true
property :host, String, required: true
property :port, String, required: true
property :groups, Array, required: true
property :name, String

## Properties for the 'unlink' command
property :force, [TrueClass]

## Action options
action :link do
  link_options = []
  if new_resource.name
    link_options.insert(0, "--name=#{new_resource.name}")
  end
  if new_resource.groups
    link_options.insert(0, "--groups=#{new_resource.groups.join(',')}")
  end
  if new_resource.port
    link_options.insert(0, "--port=#{new_resource.port}")
  end
  if new_resource.host
    link_options.insert(0, "--host=#{new_resource.host}")
  end
  if new_resource.key
    link_options.insert(0, "--key=#{new_resource.key}")
  end
  execute NESSUSCLI_COMMAND do
    command "#{NESSUSCLI_COMMAND} agent link #{link_options.join(' ')}"
  end
end

action :unlink do
  if new_resource.force
    execute NESSUSCLI_COMMAND do
      command "#{NESSUSCLI_COMMAND} agent unlink --force"
    end
  else
    execute NESSUSCLI_COMMAND do
      command "#{NESSUSCLI_COMMAND} agent unlink"
    end
  end
end
