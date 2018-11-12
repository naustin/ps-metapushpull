# create lookup table
$MemberNameLookup = @{}
$MemberNameLookup.Add('applications','CustomApplication')
$MemberNameLookup.Add('classes','ApexClass')
$MemberNameLookup.Add('components','ApexComponent')
$MemberNameLookup.Add('customMetadata','CustomMetadata')
$MemberNameLookup.Add('email','EmailTemplate')
$MemberNameLookup.Add('flowDefinitions','FlowDefinition')
$MemberNameLookup.Add('flows','Flow')
$MemberNameLookup.Add('globalValueSets','GlobalValueSet')
$MemberNameLookup.Add('groups','Group')
$MemberNameLookup.Add('labels','CustomLabel')
$MemberNameLookup.Add('layouts','Layout')
$MemberNameLookup.Add('objects','CustomObject')
$MemberNameLookup.Add('pages','ApexPage')
$MemberNameLookup.Add('pathAssistants','PathAssistant')
$MemberNameLookup.Add('permissionsets','PermissionSet')
$MemberNameLookup.Add('profiles','Profile')
$MemberNameLookup.Add('queues','Queue')
$MemberNameLookup.Add('quickActions','QuickAction')
$MemberNameLookup.Add('sharingRules','SharingRules')
$MemberNameLookup.Add('tabs','CustomTab')
$MemberNameLookup.Add('workflows','Workflow')

$NewPackageFile = "<Package xmlns=`"http://soap.sforce.com/2006/04/metadata`">  `r`n"

function ConvertMemberName {
    param( [string]$NameFromDiffFile)
    
    $MemberObjectName = $MemberNameLookup["$NameFromDiffFile"] 

    if ($MemberObjectName -eq $null){
        Write-Host "Error while attempting to convert '$NameFromDiffFile' to package file member name.  Make sure this value has an entry in the lookup table. "
        Break
    }

    #Try
    #{
        
       #$MemberObjectName = $MemberNameLookup["$(Get-Variable -Name $NameFromDiffFile -ValueOnly)"]
    #}
    #Catch
    #{
    #    $ErrorMessage = $_.Exception.Message   
    #}

    return $MemberObjectName
}


# Load files from diff into object table
$MemberObjects = New-Object System.Collections.ArrayList

foreach($FileName in Get-Content 'new-packagefile/diffnames.txt')
{
   if($FileName.StartsWith("force-app/main/default") -eq $false){
       Continue
   }


   $FileNameSplit = $FileName.Split('/')
   $ObjectType = $FileNameSplit[3]
   $Member = $FileNameSplit[$($FileNameSplit.Length - 1)].Split('.')[0]

   $MemberObject = New-Object -TypeName psobject
   $MemberObject | Add-Member -MemberType NoteProperty -Name ObjectType -Value $(ConvertMemberName($ObjectType))
   $MemberObject | Add-Member -MemberType NoteProperty -Name Member -Value $Member
   $MemberObject | Add-Member -MemberType NoteProperty -Name Processed -Value false

   $MemberObjects.Add($MemberObject)

}

$NewPackageFile += "    <version>43.0</version>`r`n</Package>"