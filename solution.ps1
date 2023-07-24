param([string] $name="Template", [string] $Framework="net7.0", [bool] $Entity=$true, [string] $Database="mssql")

write-host "Creating Main solution"
dotnet new sln -n "$name"

write-host "Creating Main project and dependences"
dotnet new webapi -n "$name.WebApi" -o "src/WebApi" -f "$Framework"
dotnet new classlib -n "$name.ApplicationCore" -o "src/ApplicationCore" -f "$Framework"
dotnet new classlib -n "$name.Domain" -o "src/Domain" -f "$Framework"
dotnet new classlib -n "$name.Infraestructure" -o "src/Infraestructure" -f "$Framework"
dotnet new classlib -n "$name.CrossCutting" -o "src/CrossCutting" -f "$Framework"

write-host "Creating Unit test Project"
dotnet new xunit -n "$name.UnitTest" -o "test/UnitTest" -f "$Framework"

write-host "Adding project reference to solution"
dotnet sln "$name.sln" add "src/WebApi" --solution-folder "src"
dotnet sln "$name.sln" add "src/Domain" --solution-folder "src"
dotnet sln "$name.sln" add "src/ApplicationCore" --solution-folder "src"
dotnet sln "$name.sln" add "src/Infraestructure" --solution-folder "src"
dotnet sln "$name.sln" add "src/CrossCutting" --solution-folder "src"
dotnet sln "$name.sln" add "test/UnitTest" --solution-folder "test"

Write-Host "Adding project dependence"
dotnet add "src/ApplicationCore" reference "src/Domain"
dotnet add "src/Infraestructure" reference "src/Domain"
dotnet add "src/CrossCutting" reference "src/ApplicationCore"
dotnet add "src/CrossCutting" reference "src/Infraestructure"
dotnet add "src/WebApi" reference "src/CrossCutting"
dotnet add "test/UnitTest" reference "src/WebApi"

write-host "Adding dotnet tools"
dotnet new tool-manifest

dotnet tool install Versionize --version 1.18.0

if($Entity)
{
    write-host "Installing Entity Framework"
    
    dotnet tool install dotnet-ef --version 7.0.9
    
    switch ($Database) {
        "Oracle"
        {
            dotnet add "src/Infraestructure" package Oracle.EntityFrameworkCore --version 7.21.9
        }
        "MySql"
        {
            dotnet add "src/Infraestructure" package MySql.EntityFrameworkCore --version 7.0.5
        }
        "Pomelo"
        {
            dotnet add "src/Infraestructure" package Pomelo.EntityFrameworkCore.MySql --version 7.0.0
        }
        "npgsql"
        {
            dotnet add "src/Infraestructure" package Npgsql.EntityFrameworkCore.PostgreSQL --version 7.0.4
        }
        "sqlite"
        {
            dotnet add "src/Infraestructure" package Microsoft.EntityFrameworkCore.Sqlite --version 7.0.9
        }
        "mssql" 
        {  
            dotnet add "src/Infraestructure" package Microsoft.EntityFrameworkCore.SqlServer --version 7.0.9
        }
        Default 
        {
            dotnet add "src/Infraestructure" package Microsoft.EntityFrameworkCore.SqlServer --version 7.0.9
        }
    }
    dotnet add "src/Infraestructure" package Microsoft.EntityFrameworkCore --version 7.0.9
    dotnet add "src/Infraestructure" package Microsoft.EntityFrameworkCore.Relational --version 7.0.9
}

write-host "Solution created with success"

write-host "solution name: $name.sln"
write-host "Framework used: $Framework"