#Requires -Modules @{ModuleName="OZO";ModuleVersion="1.5.0"},@{ModuleName="OZOLogger";ModuleVersion="1.1.0"} -RunAsAdministrator

<#PSScriptInfo
    .VERSION 1.0.1
    .GUID 26313204-248b-4816-89de-4c605134b2ca
    .AUTHOR Andy Lievetz <alievertz@onezeroone.dev>
    .COMPANYNAME One Zero One
    .COPYRIGHT This script is released under the terms of the GNU General Public License ("GPL") version 2.0.
    .TAGS 
    .LICENSEURI https://github.com/onezeroone-dev/OZO-Remove-AppX-Packages/blob/main/LICENSE
    .PROJECTURI https://github.com/onezeroone-dev/OZO-Remove-AppX-Packages
    .ICONURI 
    .EXTERNALMODULEDEPENDENCIES 
    .REQUIREDSCRIPTS 
    .EXTERNALSCRIPTDEPENDENCIES 
    .RELEASENOTES https://github.com/onezeroone-dev/OZO-Remove-AppX-Packages/blob/main/CHANGELOG.md
#>

<# 
    .DESCRIPTION 
    Removes provisioned AppX packages for the current user and available AppX packages from the running system.
    .PARAMETER Packages
    A comma-separated list of packages to remove.
    .LINK
    https://github.com/onezeroone-dev/OZO-Remove-AppX-Packages/blob/main/README.md
    .NOTES
    Run this script in an Administrator PowerShell.
#>
[CmdLetBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory=$true,HelpMessage="A comma-separated list of packages to remove")][Array] $Packages
)

# MAIN
# Variables
[Array] $AppxPackages            = (Get-AppxPackage)
[Array] $AppxProvisionedPackages = (Get-AppxProvisionedPackage -Online)
# Determine if the session is user-interactive
If ((Get-OZOUserInteractive) -eq $true) {
    # Session is user-interactive; iterate through the list of packages
    ForEach ($Package in $Packages) {
        Write-Host ("Processing available Appx packages.")
        # Determine if the AppxPackages array contains the package
        If (($AppxPackages).Name -Contains $Package) {
            # The array contains the package; remove it
            Try {
                Remove-AppxPackage -Package ($AppxPackages | Where-Object {$_.Name -eq $Package}).PackageFullName -ErrorAction Stop
                # Success
                Write-Host ("Removed the " + $Package + " available package.")
            } Catch {
                # Failure
                Write-Host ("Error removing the " + $Package + "available package. Error message is: " + $_)
            }
        } Else {
            Write-Host ("Did not find " + $Package + " among the available Appx packages.")
        }
        Write-Host ("Processing provisioned Appx packages.")
        # Determine if the AppxProvisionedPackages array contains the package
        If (($AppxProvisionedPackages).DisplayName -Contains $Package) {
            # The array contains the package; remove it
            Try {
                Remove-AppxProvisionedPackage -Online -PackageName ($AppxProvisionedPackages | Where-Object {$_.DisplayName -eq $Package}).PackageName | Out-Null
                Write-Host ("Removed the " + $Package + " provisioned package.")
            } Catch {
                Write-Host ("Error removing the " + $Package + "provisioned package. Error message is: " + $_)
            }
        } Else {
            Write-Host ("Did not find " + $Package + " among the provisioned Appx packages.")
        }
    }
} Else {
    # Session is not user-interactive
    Write-OZOProvider -Message "Please run this script in a user-interactive session." -Level "Error"
}
