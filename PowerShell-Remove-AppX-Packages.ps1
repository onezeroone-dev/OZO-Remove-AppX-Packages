# README
# Run this script in an Administrative PowerShell to remove listed
# AppXPackages and corresponding AppXProvisionedPackages.

# VARIABLES
# Comma-separated list of AppX Packages to remove
# Get package names using PS C:\> (Get-AppxPackage).Name
$AppXPackages = @(
  "Microsoft.BingWeather",
  "Microsoft.GetHelp",
  "Microsoft.Getstarted",
  "Microsoft.Messaging",
  "Microsoft.MicrosoftSolitaireCollection",
  "Microsoft.OneConnect",
  "Microsoft.People",
  "Microsoft.SkypeApp",
  "Microsoft.Wallet",
  "Microsoft.windowscommunicationsapps",
  "Microsoft.WindowsMaps",
  "Microsoft.YourPhone",
  "Microsoft.ZuneMusic",
  "Microsoft.ZuneVideo"
)

# MAIN
# Remove AppxPackage
ForEach ($Package in $AppXPackages) {
  if ($null -ne (Get-AppxPackage $Package).PackageFullName) {
    Remove-AppxPackage -Package (Get-AppxPackage $Package).PackageFullName
  }
}
# Remove AppxProvisionedPackage
ForEach ($Package in (Get-AppxProvisionedPackage -Online)) {
  if ($AppxPackages -Contains $Package.DisplayName) {
    Remove-AppXProvisionedPackage -Online -PackageName $Package.PackageName
  }
}
