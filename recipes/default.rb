#
# Cookbook:: test_windows_extra_disks
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# https://gist.github.com/JasonCarter80/5a9601ca1d7713929fef63ce6bf0dc6d
powershell_script 'Initialize Drives' do
  code <<-EOH
  $drive = Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR
  Get-Disk -Number 1 |  New-Partition -DriveLetter 'F'  -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false -AllocationUnitSize 65536
  Get-Disk -Number 2 |  New-Partition -DriveLetter 'G'  -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false -AllocationUnitSize 65536
  Get-Disk -Number 3 |  New-Partition -DriveLetter 'H'  -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Logs" -Confirm:$false -AllocationUnitSize 65536
  Get-Disk -Number 4 |  New-Partition -DriveLetter 'I'  -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Temp" -Confirm:$false -AllocationUnitSize 65536
  EOH
end
