foreach($file in Get-Content 'files.txt')
{
  $TargetFile = $(Join-Path $pwd $file)

  Copy-Item -Path $TargetFile -Destination "$pwd\output"
}