#requires -Module PSDevOps

Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubWorkflow

Push-Location ($PSScriptRoot | Split-Path)

$workflowPath = 
    Join-Path $pwd ".github" | 
    Join-Path -ChildPath workflows |
    Join-Path -ChildPath "BuildFlexibits.yml"

if (-not (Test-Path $workflowPath)) {
    $null = New-Item -ItemType File -path $workflowPath -Force
}

New-GitHubWorkflow -Name "Build Flexibits" -On Push, PullRequest, Demand -Job BuildFlexibits -OutputPath $workflowPath

Pop-Location