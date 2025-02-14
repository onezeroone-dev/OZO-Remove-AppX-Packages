#Requires -RunAsAdministrator

<#PSScriptInfo
    .VERSION 1.0.0
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
    Run this script in an Administrator PowerShell
#>
[CmdLetBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory=$true,HelpMessage="A comma-separated list of packages to remove")][Array] $Packages
)

# MAIN
# Variables
[Array] $AppxPackages = (Get-AppxPackage)
[Array] $AppxProvisionedPackages = (Get-AppxProvisionedPackage -Online)

# Remove AppxPackage
ForEach ($Package in $Packages) {
    If (($AppxPackages).Name -Contains $Package) {
        Remove-AppxPackage -Package ($AppxPackages | Where-Object {$_.Name -eq $Package}).PackageFullName
    }
    If (($AppxProvisionedPackages).DisplayName -Contains $Package) {
        Remove-AppxProvisionedPackage -Online -PackageName ($AppxPackages | Where-Object {$_.DisplayName -eq $Package})
    }
}
