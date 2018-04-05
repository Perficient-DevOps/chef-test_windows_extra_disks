#
# Cookbook:: test_windows_extra_disks
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# https://gist.github.com/JasonCarter80/5a9601ca1d7713929fef63ce6bf0dc6d
powershell_script 'Initialize Drives' do
  code <<-EOH
  $drive = Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR
  $drive = Get-Disk | Where NumberOfPartitions -eq 0
  $drive |  New-Partition -DriveLetter 'F'  -Size 10MB | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false -AllocationUnitSize 65536
  $drive |  New-Partition -DriveLetter 'G'  -Size 10MB | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false -AllocationUnitSize 65536
  $drive |  New-Partition -DriveLetter 'H'  -Size 10MB | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Logs" -Confirm:$false -AllocationUnitSize 65536
  $drive |  New-Partition -DriveLetter 'I'  -Size 10MB | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Temp" -Confirm:$false -AllocationUnitSize 65536
  EOH
end
