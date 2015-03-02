package 'lib32gcc1'

user 'steam' do
  comment 'Steam User'
  supports manage_home: true
  home '/home/steam'
  gid 'users'
  shell '/bin/bash'
end

steamcmd_dir = node['steamcmd']['dir']
directory steamcmd_dir do
  user 'steam'
  group 'users'
  mode 0755
end

tar_extract node['steamcmd']['url'] do
  target_dir steamcmd_dir
  download_dir '/tmp'
  user 'steam'
  group 'users'
  creates ::File.join(steamcmd_dir, 'steamcmd.sh')
end

# Put a wrapper in the path, we can't use a symlink because the
# Steam root directory detection is broken in steamcmd.sh
file '/usr/bin/steamcmd' do
  content <<-EOF
#!/bin/bash
#{::File.join(steamcmd_dir, 'steamcmd.sh')} $@
  EOF
  mode 0777
end

# Login to force an update and check everything is working
execute 'update-steamcmd' do
  command 'steamcmd +login anonymous +quit'
  user 'steam'
  group 'users'
end
