param([string] $Name="Template", [string] $Framework="net7.0")

dotnet new sln -n "$Name"
dotnet new webapi -n "$Name.WebApi" -o "$Name.WebApi" -f "$Framework"
dotnet new classlib -n "$Name.Domain" -o "$Name.Domain" -f "$Framework"
dotnet new classlib -n "$Name.Infrastructure" -o "$Name.Infrastructure" -f "$Framework"
dotnet new classlib -n "$Name.CrossCutting" -o "$Name.CrossCutting" -f "$Framework"
dotnet new xunit -n "$Name.UnitTest" -o "$Name.UnitTest" -f "$Framework"
dotnet sln "$Name.sln" add "$Name.WebApi" --solution-folder "src"
dotnet sln "$Name.sln" add "$Name.Domain" --solution-folder "src"
dotnet sln "$Name.sln" add "$Name.Infrastructure" --solution-folder "src"
dotnet sln "$Name.sln" add "$Name.CrossCutting" --solution-folder "src"
dotnet sln "$Name.sln" add "$Name.UnitTest" --solution-folder "test"

dotnet add "$Name.UnitTest/$Name.UnitTest.csproj" reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" "$Name.Infrastructure/$Name.Infrastructure.csproj" "$Name.WebApi/$Name.WebApi.csproj"
dotnet add "$Name.WebApi/$Name.WebApi.csproj"     reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" "$Name.Infrastructure/$Name.Infrastructure.csproj"
dotnet add "$Name.Infrastructure/$Name.Infrastructure.csproj"       reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" 
dotnet add "$Name.Domain/$Name.Domain.csproj"     reference "$Name.CrossCutting/$Name.CrossCutting.csproj" 


write-host "Solution created with success"

write-host "solution name: $Name.sln"
write-host "Framework used: $Framework"