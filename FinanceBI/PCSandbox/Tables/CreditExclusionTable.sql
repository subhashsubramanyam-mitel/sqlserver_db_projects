CREATE TABLE [PCSandbox].[CreditExclusionTable] (
    [ChargeDescription] NVARCHAR (255) NOT NULL,
    [Exclude?]          NVARCHAR (255) NULL,
    [DateModified]      DATETIME2 (4)  DEFAULT (getdate()) NOT NULL,
    [DateCreated]       DATETIME2 (4)  DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]        NVARCHAR (50)  DEFAULT (suser_sname()) NOT NULL,
    [Id]                INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [PK_CreditExclusionTable] PRIMARY KEY CLUSTERED ([ChargeDescription] ASC)
);


GO

CREATE TRIGGER PCSandbox.TG_CreditExclusionTable
   ON  PCSandbox.CreditExclusionTable
   AFTER INSERT,UPDATE AS 
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

 declare @username varchar(127);
 declare @created datetime2;

 
 set @created = GETUTCDATE();
 set @username = dbo.UfnGetCredentials();
 
 -- if it was updated outside the mantle context then we need to update the audit fields ourselves

 if(@username is null)
 begin
  set @username = SYSTEM_USER;
  
  update 
   c
  set
   c.ModifiedBy = @username,
   c.DateModified = @created
  from
   
PCSandbox.CreditExclusionTable c inner join deleted d
    on c.Id = d.Id;
    
  if (@@ROWCOUNT = 0) -- uh oh, this was an insert, not an update
  begin
   update 
   c
  set
   c.ModifiedBy = @username,
   c.DateModified = @created,
   c.DateCreated = @created
  from
   PCSandbox.CreditExclusionTable c inner join inserted i
    on c.Id = i.Id;
  end;
 end;

END
