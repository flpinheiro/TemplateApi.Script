# Create new solution script

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

./solution.ps1 -Name <Name> -Framework <FRAMEWORK>

-Framework <FRAMEWORK>

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

execute ```dotnet --list-sdks``` to know wich sdk is installed on yur machine

## default values

* -Name = Template
* -Framework = net6.0