
# Gets the current powershell major version
# For more details regarding powershell installation, check the official docs at:
# https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell
function get-current-powershell-major-version() {
    $currentMajorVersion = $PSVersionTable.PSVersion.Major
    return $currentMajorVersion
}

# Check the current powershell required major version
# For more details regarding powershell installation, check the official docs at:
# https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell
function is-required-powershell-major-version-or-later($currentMajorVersion, $requiredMajorVersion) {
    if($currentMajorVersion -ge $requiredMajorVersion) {
        return $true
    }
    return $false
}

# Get information about installed .net framework sdks.
# https://www.microsoft.com/net/download/visual-studio-sdks
function get-installed-net-framework-sdks()
{
    $existingSdks =
        Get-ChildItem "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" `
        | Get-ItemProperty
    $existingSdks
}

# Check if the current system has the required .net framework sdk intalled based on the release version value
# https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed
function is-required-net-framework-sdk-or-greater-installed($installedNetFrameworkSDKs, $requiredReleaseVersion)
{
    $releases =
        $installedNetFrameworkSDKs `
        | Get-ItemPropertyValue -Name Release

    ForEach ($release in $releases) {
        if ($release -ge $requiredReleaseVersion) {
            return $true
        }
    }
    return $false
}