$disks = Get-Disk | Where partitionstyle -EQ 'raw' | sortnumber

$letters = 70..89 | ForEach-Object { [char]$_}
$count = 0
$lables = "data1","data2"

ForEach ($disk in $disks) {
    $driveletter = $letters[$count].ToString()
    $disk |
    Initialize-Disk -PartitionStyle MBR -PassThru
    New-Partition -UseMaximumSize -DriveLetter $driveletter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel $lables[$count] -Confirm:$false -Force
$count++
}
