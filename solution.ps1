param([string] $Name="Template", [string] $Framework="net6.0")

dotnet new sln -n "$Name"
dotnet new webapi -n "$Name.WebApi" -o "$Name.WebApi" -f "$Framework"
dotnet new classlib -n "$Name.Domain" -o "$Name.Domain" -f "$Framework"
dotnet new classlib -n "$Name.Infra" -o "$Name.Infra" -f "$Framework"
dotnet new classlib -n "$Name.CrossCutting" -o "$Name.CrossCutting" -f "$Framework"
dotnet new xunit -n "$Name.UnitTest" -o "$Name.UnitTest" -f "$Framework"
dotnet sln "$Name.sln" add "$Name.WebApi"
dotnet sln "$Name.sln" add "$Name.Domain"
dotnet sln "$Name.sln" add "$Name.Infra"
dotnet sln "$Name.sln" add "$Name.CrossCutting"
dotnet sln "$Name.sln" add "$Name.UnitTest"

dotnet add "$Name.UnitTest/$Name.UnitTest.csproj" reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" "$Name.Infra/$Name.Infra.csproj" "$Name.WebApi/$Name.WebApi.csproj"
dotnet add "$Name.WebApi/$Name.WebApi.csproj"     reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" "$Name.Infra/$Name.Infra.csproj"
dotnet add "$Name.Infra/$Name.Infra.csproj"       reference "$Name.CrossCutting/$Name.CrossCutting.csproj" "$Name.Domain/$Name.Domain.csproj" 
dotnet add "$Name.Domain/$Name.Domain.csproj"     reference "$Name.CrossCutting/$Name.CrossCutting.csproj" 


write-host "Solution created with success"

write-host "solution name: $Name.sln"
write-host "Framework used: $Framework"