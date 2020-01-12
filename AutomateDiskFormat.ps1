Function SetupDisks()
{
 # This will initialize and format any uninitialized disks on the system and assign the next available drive letters to them
 
 $diskstoformat = get-disk | where-object {$_.numberofpartitions -eq 0} | sort {$_.number}
Foreach($disk in $diskstoformat)
 {
 $disknum = $disk.number
 $label = 'Data'+$disknum
$disk | Initialize-Disk -PartitionStyle MBR -ErrorAction SilentlyContinue
new-partition -disknumber $disknum -usemaximumsize -assigndriveletter:$False $part = get-partition -disknumber $disknum -number 1 if($disknum -gt 1) { $part | Format-Volume -FileSystem NTFS -NewFileSystemLabel $label -AllocationUnitSize ‘65536’ -Confirm:$false -Force } else { $part | Format-Volume -FileSystem NTFS -NewFileSystemLabel $label -Confirm:$false -Force } end $part | Add-PartitionAccessPath -AssignDriveLetter } }
