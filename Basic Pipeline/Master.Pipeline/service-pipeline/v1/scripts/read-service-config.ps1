#Install-Module powershell-yaml -Scope CurrentUser
if (Get-Module -ListAvailable -Name powershell-yaml) {
    #Write-Host "powershell-yaml Already Installed"
} 
else {
    try {
        Install-Module -Name powershell-yaml -Scope CurrentUser -Force
    }
    catch [Exception] {
        $_.message 
        exit
    }
}

$serviceConfigFile=$args[0]
$serviceconfig = [IO.File]::ReadAllText("service-repo/$serviceConfigFile")
$parsedYAML = ConvertFrom-Yaml $serviceconfig -AllDocuments

####################
#Read build parameters

$value = $parsedYAML.buildParameter.repoName
Write-Host "##vso[task.setvariable variable=param.repoName;isOutput=true]$value"

$value = $parsedYAML.buildParameter.buildPlatform
Write-Host "##vso[task.setvariable variable=param.buildPlatform;isOutput=true]$value"

$value = $parsedYAML.buildParameter.buildConfiguration
Write-Host "##vso[task.setvariable variable=param.buildConfiguration;isOutput=true]$value"

$value = $parsedYAML.buildParameter.projectName
Write-Host "##vso[task.setvariable variable=param.projectName;isOutput=true]$value"

$value = $parsedYAML.buildParameter.solution
Write-Host "##vso[task.setvariable variable=param.solution;isOutput=true]$value"


####################
#Read branch parameters

if($args[1] -eq $True)
{
    $branch="main"
}

$value = $parsedYAML.build.branches.$branch.build
Write-Host "##vso[task.setvariable variable=pipeline.build;isOutput=true]$value"





