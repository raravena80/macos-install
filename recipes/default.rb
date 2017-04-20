#
# Cookbook:: macos-install
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'Get xcode artifacts' do
  command 'wget -O /tmp/Xcode_8.2.1.xip https://artifactory.corp.adobe.com/artifactory/generic-DI-binary-local/Xcode/8/Xcode_8.2.1.xip'
end

execute 'Clean up old version' do
  command 'sudo rm -rf /Applications/Xcode.app'
end

execute 'Create directory for Xcode Application' do
  command 'sudo mkdir -p /Applications/Xcode.app'
end

execute 'Getting on to the Application Folder' do
  command 'cd /Applications/Xcode.app'
end

execute 'Uncompress the file' do
  command 'xar -xf /tmp/Xcode_8.2.1.xip'
end

execute 'parse_pbzx2.py download' do
  command 'curl -O https://gist.githubusercontent.com/pudquick/ff412bcb29c9c1fa4b8d/raw/24b25538ea8df8d0634a2a6189aa581ccc6a5b4b/parse_pbzx2.py'
end

execute 'Decompressing the .xz chunks' do
  command 'python parse_pbzx2.py Content'
end

execute 'Installing xz' do
  command 'brew install xz'
end

execute 'xz -d' do
  command 'xz -d Content.part00.cpio.xz'
end

execute 'cpio -idm' do
  command 'sudo cpio -idm < ./Content.part00.cpio'
end

execute 'Moving Xcode to Applications' do
  command 'sudo mv ./Xcode.app /Applications/'
end
    
execute 'Get xcode tools' do
  command 'wget -O /tmp/Command_Line_Tools_macOS_10.12_for_Xcode_8.2.dmg https://artifactory.corp.adobe.com/artifactory/generic-DI-binary-local/Xcode/8/Command_Line_Tools_macOS_10.12_for_Xcode_8.2.dmg'
end

execute 'Attach image' do
  command 'sudo hdiutil attach /tmp/Command_Line_Tools_macOS_10.12_for_Xcode_8.2.dmg'
end

execute 'Install xcode tools' do
  command 'sudo install -pkg “/Volumes/Command Line Developer Tools/Command_Line_Tools_macOS_10.12_for_Xcode_8.2.pkg” -target /'
end
