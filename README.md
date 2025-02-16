# OZO Remove AppX Packages

## Description
Removes provisioned AppX packages for the current user and available AppX packages from the running system. You can generate a list of your system's available AppX packages with the following in an _Administrator_ PowerShell:
```powershell
(Get-AppxPackage).Name
```

## Installation
This script is published to the [PowerShell Gallery](https://learn.microsoft.com/en-us/powershell/scripting/gallery/overview?view=powershell-5.1). Ensure your system is configured for this repository then execute the following in an _Administrator_ PowerShell:

```powershell
Install-Script ozo-remove-appx-packages
```

## Usage
Run this script in an _Admininstrator_ PowerShell.
```powershell
ozo-remove-appx-packages
    -Packages <Array>
```

## Parameters
|Parameter|Description|
|---------|-----------|
|`Packages`|A comma-separated list of packages to remove.|

## Example
```powershell
ozo-remove-appx-packages -Packages "Microsoft.BingWeather","Microsoft.SkypeApp","Microsoft.ZuneMusic"
```

## Acknowledgements
Special thanks to my employer, [Sonic Healthcare USA](https://sonichealthcareusa.com), who has supported the growth of my PowerShell skillset and enabled me to contribute portions of my work product to the PowerShell community.
