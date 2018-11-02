foreach($file in Get-Content 'files.txt')
{
  $TargetFile = $(Join-Path $pwd $file)

  Copy-Item -Path "$pwd\output" -Destination  $TargetFile
}