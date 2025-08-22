<#
    =================================================================================
    DISCLAIMER:
    This script is provided "as-is" with no warranties. Usage of this script is at
    your own risk. The author is not liable for any damages or losses arising from
    using this script. Please review the full legal disclaimer at:
    https://kaidojarvemets.com/legal-disclaimer/

    https://kaidojarvemets.com/
    =================================================================================
#>
# Variables for Azure environment
$SubscriptionId = "8a53693c-b9d9-4b0f-94ad-cd456bb57e73"
$ResourceGroupName = "8a53693c-b9d9-4b0f-94ad-cd456bb57e73"
$WorkspaceName = "sentinel-lab-iac-rg"
$ApiVersion = "2024-03-01"

# Construct the API URLs
$BaseUri = "https://management.azure.com"
$ResourcePath = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.OperationalInsights/workspaces/$WorkspaceName/providers/Microsoft.SecurityInsights"
$InstalledEndpoint = "contentPackages"
$AvailableEndpoint = "contentProductPackages"
$ApiVersionParam = "?api-version=$ApiVersion"

$InstalledUri = "$BaseUri$ResourcePath/$InstalledEndpoint$ApiVersionParam"
$AvailableUri = "$BaseUri$ResourcePath/$AvailableEndpoint$ApiVersionParam"

function Get-ContentHubSolutions {
    param (
        [string]$Uri
    )

    try {
        $Response = Invoke-AzRestMethod -Method GET -Uri $Uri -ErrorAction Stop

        if ($Response.StatusCode -eq 200) {
            $Content = $Response.Content | ConvertFrom-Json
            return $Content.value
        }
        else {
            Write-Error "API call failed with status code: $($Response.StatusCode)"
            return $null
        }
    }
    catch {
        Write-Error "An error occurred: $($Error[0])"
        return $null
    }
}

# Get both installed and available solutions
$InstalledSolutions = Get-ContentHubSolutions -Uri $InstalledUri
$AvailableSolutions = Get-ContentHubSolutions -Uri $AvailableUri

# Find solutions that need updates
$UpdateNeeded = foreach ($Installed in $InstalledSolutions) {
    $Available = $AvailableSolutions | Where-Object {
        $PSITEM.properties.displayName -eq $Installed.properties.displayName
    }

    if ($Available.properties.version -gt $Installed.properties.version) {
        [PSCustomObject]@{
            DisplayName = $Installed.properties.displayName
            CurrentVersion = $Installed.properties.version
            AvailableVersion = $Available.properties.version
            ContentId = $Installed.properties.contentId
        }
    }
}

function Export-ContentHubUpdatesToHtml {
    param (
        [Parameter(Mandatory = $true)]
        [Array]$UpdateData,
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    try {
        $HtmlHeader = @"
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #0066cc; }
            table { border-collapse: collapse; width: 100%; margin-top: 20px; }
            th { background-color: #0066cc; color: white; padding: 12px; text-align: left; }
            td { padding: 8px; border-bottom: 1px solid #ddd; }
            tr:nth-child(even) { background-color: #f9f9f9; }
            tr:hover { background-color: #f5f5f5; }
            .summary { margin: 20px 0; padding: 10px; background-color: #f0f8ff; border-left: 5px solid #0066cc; }
        </style>
"@

        $HtmlBody = @"
        <h1>Microsoft Sentinel Content Hub Updates Report</h1>
        <div class="summary">
            <p>Report Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
            <p>Total Solutions Requiring Updates: $($UpdateData.Count)</p>
        </div>
"@

        $TableData = $UpdateData | ConvertTo-Html -Fragment -As Table

        $FullHtml = @"
        <!DOCTYPE html>
        <html>
        <head>
            $HtmlHeader
        </head>
        <body>
            $HtmlBody
            $TableData
        <script>(()=>{class RocketElementorPreload{constructor(){this.deviceMode=document.createElement("span"),this.deviceMode.id="elementor-device-mode-wpr",this.deviceMode.setAttribute("class","elementor-screen-only"),document.body.appendChild(this.deviceMode)}t(){let t=getComputedStyle(this.deviceMode,":after").content.replace(/"/g,"");this.animationSettingKeys=this.i(t),document.querySelectorAll(".elementor-invisible[data-settings]").forEach((t=>{const e=t.getBoundingClientRect();if(e.bottom>=0&&e.top<=window.innerHeight)try{this.o(t)}catch(t){}}))}o(t){const e=JSON.parse(t.dataset.settings),i=e.m||e.animation_delay||0,n=e[this.animationSettingKeys.find((t=>e[t]))];if("none"===n)return void t.classList.remove("elementor-invisible");t.classList.remove(n),this.currentAnimation&&t.classList.remove(this.currentAnimation),this.currentAnimation=n;let o=setTimeout((()=>{t.classList.remove("elementor-invisible"),t.classList.add("animated",n),this.l(t,e)}),i);window.addEventListener("rocket-startLoading",(function(){clearTimeout(o)}))}i(t="mobile"){const e=[""];switch(t){case"mobile":e.unshift("_mobile");case"tablet":e.unshift("_tablet");case"desktop":e.unshift("_desktop")}const i=[];return["animation","_animation"].forEach((t=>{e.forEach((e=>{i.push(t+e)}))})),i}l(t,e){this.i().forEach((t=>delete e[t])),t.dataset.settings=JSON.stringify(e)}static run(){const t=new RocketElementorPreload;requestAnimationFrame(t.t.bind(t))}}document.addEventListener("DOMContentLoaded",RocketElementorPreload.run)})();</script></body>
        </html>
"@

        $FullHtml | Out-File -FilePath $FilePath -ErrorAction Stop
        Write-Output "HTML report exported to: $FilePath"
    }
    catch {
        Write-Error "Failed to export HTML report: $($Error[0])"
    }
}

function Export-ContentHubUpdatesToJson {
    param (
        [Parameter(Mandatory = $true)]
        [Array]$UpdateData,
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    try {
        $JsonObject = [PSCustomObject]@{
            ReportGenerated = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
            TotalUpdatesNeeded = $UpdateData.Count
            Solutions = $UpdateData
        }

        $JsonObject | ConvertTo-Json -Depth 10 | Out-File -FilePath $FilePath -ErrorAction Stop
        Write-Output "JSON export completed to: $FilePath"
    }
    catch {
        Write-Error "Failed to export JSON file: $($Error[0])"
    }
}

# Example usage:
$ReportPath = "ContentHubUpdates_$(Get-Date -Format 'yyyyMMdd').html"
$JsonPath = "ContentHubUpdates_$(Get-Date -Format 'yyyyMMdd').json"
Export-ContentHubUpdatesToHtml -UpdateData $UpdateNeeded -FilePath $ReportPath
Export-ContentHubUpdatesToJson -UpdateData $UpdateNeeded -FilePath $JsonPath