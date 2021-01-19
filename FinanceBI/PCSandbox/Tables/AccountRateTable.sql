CREATE TABLE [PCSandbox].[AccountRateTable] (
    [Region]               NCHAR (6)      NOT NULL,
    [AccountID]            BIGINT         NULL,
    [Client Name]          NVARCHAR (255) NULL,
    [PaymentPlanOfRecord]  NVARCHAR (255) NULL,
    [Account CommRate]     FLOAT (53)     NULL,
    [PCPlanName]           NVARCHAR (50)  NULL,
    [Include Usage?]       NVARCHAR (255) NULL,
    [Crediting Partner ID] BIGINT         NULL,
    [Crediting Partner]    NVARCHAR (255) NULL,
    [SubAgentId]           NVARCHAR (128) NULL,
    [SubAgent]             NVARCHAR (512) NULL,
    [RepName]              NVARCHAR (256) NULL,
    [Notes]                NVARCHAR (255) NULL,
    [LichenAccountID]      BIGINT         NULL,
    [Id]                   INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DateCreated]          DATETIME2 (4)  CONSTRAINT [DF__AccountRa__DateC__7094766C] DEFAULT (getdate()) NOT NULL,
    [DateModified]         DATETIME2 (4)  CONSTRAINT [DF__AccountRa__DateM__6FA05233] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]           NVARCHAR (50)  CONSTRAINT [DF__AccountRa__Modif__71889AA5] DEFAULT (suser_sname()) NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_Region_AccountID_Unique]
    ON [PCSandbox].[AccountRateTable]([Region] ASC, [AccountID] ASC);


GO
CREATE TRIGGER PCSandbox.TG_AccountRateTable
   ON  PCSandbox.AccountRateTable
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
   
PCSandbox.AccountRateTable c inner join deleted d
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
   PCSandbox.AccountRateTable c inner join inserted i
    on c.Id = i.Id;
  end;
 end;

END

GO
GRANT INSERT
    ON OBJECT::[PCSandbox].[AccountRateTable] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[PCSandbox].[AccountRateTable] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[PCSandbox].[AccountRateTable] TO [CANDY\TAbenova]
    AS [dbo];

