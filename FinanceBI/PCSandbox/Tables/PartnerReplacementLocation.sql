CREATE TABLE [PCSandbox].[PartnerReplacementLocation] (
    [Region]                            NCHAR (6)       NULL,
    [LocationID]                        BIGINT          NULL,
    [Account Name]                      NVARCHAR (255)  NULL,
    [Crediting Partner ID]              BIGINT          NULL,
    [Crediting Partner]                 NVARCHAR (255)  NULL,
    [Location Adjusted Commission Rate] FLOAT (53)      NULL,
    [Include Usage?]                    NCHAR (10)      CONSTRAINT [DF_PartnerReplacementLocation_Include Usage?] DEFAULT (N'No') NULL,
    [SubAgentId]                        NVARCHAR (128)  NULL,
    [SubAgent]                          NVARCHAR (512)  NULL,
    [RepName]                           NVARCHAR (256)  NULL,
    [Notes]                             NVARCHAR (1024) NULL,
    [Id]                                INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DateModified]                      DATETIME2 (4)   CONSTRAINT [DF__PartnerRe__DateM__75592B89] DEFAULT (getdate()) NOT NULL,
    [DateCreated]                       DATETIME2 (4)   CONSTRAINT [DF__PartnerRe__DateC__764D4FC2] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]                        NVARCHAR (50)   CONSTRAINT [DF__PartnerRe__Modif__774173FB] DEFAULT (suser_sname()) NOT NULL,
    [Partner From Data]                 NVARCHAR (255)  NULL,
    [lichenlocationid]                  BIGINT          NULL,
    CONSTRAINT [PK_PartnerReplacementLocation] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER PCSandbox.TG_PartnerReplacementLocation
   ON  PCSandbox.PartnerReplacementLocation
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
   
PCSandbox.PartnerReplacementLocation c inner join deleted d
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
   PCSandbox.PartnerReplacementLocation c inner join inserted i
    on c.Id = i.Id;
  end;
 end;

END
