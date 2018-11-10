# Read a list of file paths and build the folder structure taking the files from the Output folder


foreach($file in Get-Content 'files.txt')
{
  $FullPath = Join-Path $pwd $file
  
  $FileName = $file.split('\')[($file.split('\').count -1)]
  $TargetFile = Join-Path $pwd (Join-Path "output" $FileName)
  $DestFolder = Split-Path -Path $FullPath -Parent


  Copy-Item -Path $TargetFile -Destination  $DestFolder
}