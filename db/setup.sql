/*

Enter custom T-SQL here that would run after SQL Server has started up. 

*/

CREATE DATABASE HelloWorld;
GO

USE HelloWorld;
GO 

CREATE TABLE [Hello](
    [id] int not null,
    [text] nvarchar(255) not null,
);
GO

CREATE DATABASE Users;
GO

USE Users;
GO

CREATE TABLE [Person] (
    [id] char(36) NOT NULL,
    [name] nvarchar(250) NOT NULL,
    [surname] nvarchar(250) NOT NULL,
    [birth_day] char(10) NOT NULL,
    [cpf] char(11) NOT NULL,
    [last_update_date] datetime2 NOT NULL,
    [is_updated] bit NOT NULL DEFAULT CAST(0 AS bit),
    CONSTRAINT [PK_Person] PRIMARY KEY ([id])
);
GO

CREATE DATABASE Company;
GO

USE Company;
GO

CREATE TABLE [Companies] (
    [id] char(36) NOT NULL,
    [name] nvarchar(250) NOT NULL,
    [cnpj] char(11) NOT NULL,
);
GO