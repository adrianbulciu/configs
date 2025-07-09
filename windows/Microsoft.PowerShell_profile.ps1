oh-my-posh init pwsh --config "$env:MY_POSH_THEMES_PATH\zash.omp.json" | Invoke-Expression

# function New-CommandAlias {
#     param (
#             [string]$AliasName,
#             [string]$CommandName,
#             [bool]$RequiredArgs = $false
#           )

#         $funcName = "Invoke-$AliasName"
#         $functionDefinition = @"
#         function global:$AliasName {
#             if ($($RequiredArgs) -and `$args.Count -eq 0) {
#                 Write-Host "Error: Missing required arguments for '$AliasName'" -ForegroundColor Red
#                     return
#             }

#             if (`$args.Count -eq 0) {
#                 & $CommandName
#             } else {
#                 & $CommandName @args
#             }
#         }
# "@

#     Invoke-Expression $functionDefinition

#     Set-Alias -Name $AliasName -Value $funcName -Option AllScope -Force
# }

Register-ArgumentCompleter -Native -CommandName ssh -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    
    $sshConfigPath = "$HOME\.ssh\config"
    if (-Not (Test-Path $sshConfigPath)) { return }

    Get-Content $sshConfigPath |
        Where-Object { $_ -match '^\s*Host\s+' } |
        ForEach-Object {
            ($_ -replace '^\s*Host\s+', '') -split '\s+' 
        } |
        Where-Object { $_ -like "$wordToComplete*" } |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Remove-Item alias:curl

function Open-Project-Tabs {
    $directories = @(
            "D:\projects\web-test",
            "D:\projects\aplicatie-interna",
            "D:\projects\api"
            )

        if (-not (Get-Command wt -ErrorAction SilentlyContinue)) {
            Write-Error "Windows Terminal (wt) is not installed or not in PATH. Please install it."
                return
        }

    foreach ($dir in $directories) {
        if (Test-Path $dir) {
            $escapedDir = $dir -replace '"', '`"'
            wt new-tab powershell -NoExit -Command "Set-Location -Path ""$escapedDir"""
        } else {
            Write-Warning "Directory not found: $dir"
        }
    }
}

Import-Module posh-git -arg 0,0,1
$Global:_ompPoshGit = $true
$originalPrompt = $function:prompt

function Set-Title {
    $repo = git rev-parse --show-toplevel 2>$null

    if ($LASTEXITCODE -eq 0) {
        $repo = Split-Path -Leaf $repo
        $branch = git branch --show-current 2>$null

        $title = "$repo ($branch)"
    } else {
        $title = Split-Path -Leaf (Get-Location)
    }

    $host.UI.RawUI.WindowTitle = $title
}

function prompt {
    Set-Title
    & $originalPrompt
}

#### GIT FUNCTIONS ####

function Git-Status { git status $args }
function Git-Pull { git pull $args }
function Git-Add { git add $args }
function Git-Restore { git restore $args }
function Git-Restore-Staged { git restore --staged $args }
function Git-Commit { git commit -m $args }
function Git-Checkout { git checkout $args }
function Git-Checkout-Branch { git checkout -b $args }
function Git-Push-Origin { git push origin $args }


# Define aliases
Set-Alias open Start-Process
Set-Alias phpstorm phpstorm64.exe
Set-Alias -Name openproj -Value Open-Project-Tabs

Set-Alias -Name gts -Value Git-Status -Option AllScope -Force
Set-Alias -Name gtp -Value Git-Pull -Option AllScope -Force
Set-Alias -Name gta -Value Git-Add -Option AllScope -Force
Set-Alias -Name gtr -Value Git-Restore -Option AllScope -Force
Set-Alias -Name gtrs -Value Git-Restore-Staged -Option AllScope -Force
Set-Alias -Name gtcm -Value Git-Commit -Option AllScope -Force
Set-Alias -Name gtc -Value Git-Checkout -Option AllScope -Force
Set-Alias -Name gtcb -Value Git-Checkout-Branch -Option AllScope -Force
Set-Alias -Name gtpo -Value Git-Push-Origin -Option AllScope -Force

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
