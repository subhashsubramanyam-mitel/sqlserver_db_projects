CREATE TABLE [PCSandbox].[PartnerReplacementServiceId] (
    [Region]                  NCHAR (6)      NULL,
    [Service ID]              BIGINT         NOT NULL,
    [Crediting Partner ID]    BIGINT         NULL,
    [Crediting Partner]       NVARCHAR (255) NULL,
    [Service Commission Rate] FLOAT (53)     NULL,
    [Include Usage?]          NVARCHAR (255) NULL,
    [SubAgentId]              NVARCHAR (128) NULL,
    [SubAgent]                NVARCHAR (512) NULL,
    [RepName]                 NVARCHAR (256) NULL,
    [Id]                      INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DateModified]            DATETIME2 (4)  CONSTRAINT [DF__PartnerRe__DateM__78359834] DEFAULT (getdate()) NOT NULL,
    [DateCreated]             DATETIME2 (4)  CONSTRAINT [DF__PartnerRe__DateC__7929BC6D] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]              NVARCHAR (50)  CONSTRAINT [DF__PartnerRe__Modif__7A1DE0A6] DEFAULT (suser_sname()) NOT NULL,
    CONSTRAINT [PK_PartnerReplacementServiceId] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER PCSandbox.TG_PartnerReplacementServiceId
   ON  PCSandbox.PartnerReplacementServiceId
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
   
PCSandbox.PartnerReplacementServiceId c inner join deleted d
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
   PCSandbox.PartnerReplacementServiceId c inner join inserted i
    on c.Id = i.Id;
  end;
 end;

END
