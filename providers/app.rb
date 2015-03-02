action :install do
  cmd = %W(steamcmd +login #{new_resource.login})
  cmd += %W(+force_install_dir #{new_resource.target_dir})
  cmd += %W(+app_update #{new_resource.app_id})
  cmd << '+validate' if new_resource.run_validate
  cmd << '+quit'
  execute cmd
end

action :remove do
end
