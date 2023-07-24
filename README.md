# Create new solution script

This is a powershell script to build a DotNet Solution Template. To use this template execute the following command.

`Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser`

`./solution.ps1 -Name <Name> -Framework <FRAMEWORK>`

## Default values

The Default values are:

* `<Name> = Template`
* `<Framework> = net7.0`

## Possible Framework Values

`-Framework <FRAMEWORK>`

Specifies the framework to target. Option not available in .NET Core 2.2 SDK.

The following table lists the default values according to the SDK version number you're using:

|SDK version | Default value|
|-|-|
|7.0 | net7.0 | 
|6.0 | net6.0 |
|5.0 | net5.0 |
|3.1 | netcoreapp3.1 |
|3.0 | netcoreapp3.0 |
|2.1 | netcoreapp2.1 |

execute `dotnet --list-sdks` to know wich sdk is installed on yur machine

# Template Architeture

The Following Architeture will be created.

![Mains Architeture](./images/Architeture.svg)

* WebApi 
  
    Main part of the Project
  
   * Controllers
   * Static Configuration Files
   * Build Files
   * 
* CrossCutting

    Responsable for configuration, security, logging and Authentication/Autorization connection with SSO service, if necessary

* ApplicationCore

    Responsable for the bussines logic

* Infraestructure

    Resposable for external connection logic such as
    * Database logic
    * Http client logic (external services)

* Domain

    Definition project. 

    * Entities, DTOs
    * Exceptions
    * Constants
    * Interfaces
    * Validation