CREATE TABLE [PCSandbox].[Adjustment] (
    [PCmonth]                         DATE            NOT NULL,
    [Region]                          NCHAR (6)       NOT NULL,
    [AccountID]                       BIGINT          NULL,
    [ClientName]                      NVARCHAR (100)  NULL,
    [PaymentPlan]                     NVARCHAR (255)  NULL,
    [CommRate]                        FLOAT (53)      NULL,
    [Description]                     NVARCHAR (512)  NULL,
    [CreditingPartnerID]              BIGINT          NULL,
    [CreditingPartner]                NVARCHAR (255)  NULL,
    [SubAgentID]                      NVARCHAR (128)  NULL,
    [SubAgent]                        NVARCHAR (512)  NULL,
    [RepName]                         NVARCHAR (256)  NULL,
    [Type]                            NVARCHAR (255)  NULL,
    [CurrencyCode]                    CHAR (3)        NULL,
    [NetBilled_LC]                    MONEY           NULL,
    [NetBilled]                       MONEY           NULL,
    [CommissionableBillingsAmount_LC] MONEY           NULL,
    [CommissionableBillingsAmount]    MONEY           NULL,
    [SalesComm_LC]                    MONEY           NULL,
    [SalesComm]                       MONEY           NULL,
    [Notes]                           NVARCHAR (1024) NULL,
    [NotesForStaff]                   NVARCHAR (1024) NULL,
    [ProductId]                       INT             NULL,
    [ProductName]                     NVARCHAR (512)  NULL,
    [Id]                              BIGINT          IDENTITY (100, 1) NOT NULL,
    [Supplier]                        NVARCHAR (255)  NULL,
    [Address]                         NVARCHAR (100)  NULL,
    [City]                            NVARCHAR (100)  NULL,
    [CodeAlpha]                       NVARCHAR (10)   NULL,
    [ZipCode]                         NVARCHAR (20)   NULL,
    [CenturyMonth]                    AS              ((12)*(datepart(year,[PCMonth])-(2000))+datepart(month,[PCMonth])),
    [invoiceMonth]                    AS              (dateadd(month,(-1),[PCMonth])),
    [ChargeType]                      NVARCHAR (50)   NULL,
    [Charge]                          MONEY           NULL,
    [LichenAccountId]                 INT             NULL,
    [DateModified]                    DATETIME2 (4)   NULL,
    [DateCreated]                     DATETIME2 (4)   NULL,
    [ModifiedBy]                      NVARCHAR (50)   NULL,
    CONSTRAINT [PK_Adjustment] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER [PCSandbox].[TG_Adjustment]
   ON  PCSandbox.Adjustment
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
   
PCSandbox.Adjustment c inner join deleted d
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
   PCSandbox.Adjustment c inner join inserted i
    on c.Id = i.Id;
  end;
 end;

END

GO
GRANT INSERT
    ON OBJECT::[PCSandbox].[Adjustment] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[PCSandbox].[Adjustment] TO [CANDY\TAbenova]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[PCSandbox].[Adjustment] TO [CANDY\TAbenova]
    AS [dbo];

