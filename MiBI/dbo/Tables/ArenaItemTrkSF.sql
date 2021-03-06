﻿CREATE TABLE [dbo].[ArenaItemTrkSF] (
    [Created]                           DATETIME      CONSTRAINT [DF_ArenaItemTrkSF_Created] DEFAULT (getdate()) NOT NULL,
    [creationDateTime]                  DATETIME      NULL,
    [lastupdateDateTime]                DATETIME      NULL,
    [effectiveDateTime]                 DATETIME      NULL,
    [EffectiveDate]                     DATETIME      NULL,
    [guid]                              VARCHAR (50)  NOT NULL,
    [name]                              VARCHAR (255) NULL,
    [number]                            VARCHAR (50)  NULL,
    [revisionNumber]                    VARCHAR (10)  NULL,
    [creator]                           VARCHAR (255) NULL,
    [description]                       VARCHAR (MAX) NULL,
    [isAssembly]                        VARCHAR (255) NULL,
    [Category]                          VARCHAR (255) NULL,
    [lifecyclePhase]                    VARCHAR (255) NULL,
    [offTheShelf]                       VARCHAR (255) NULL,
    [owner]                             VARCHAR (255) NULL,
    [productionCost]                    VARCHAR (10)  NULL,
    [prototypeCost]                     VARCHAR (10)  NULL,
    [shared]                            VARCHAR (50)  NULL,
    [standardCost]                      VARCHAR (10)  NULL,
    [targetCost]                        VARCHAR (10)  NULL,
    [targetPrice]                       VARCHAR (10)  NULL,
    [uom]                               VARCHAR (50)  NULL,
    [SKUNumber]                         VARCHAR (255) NULL,
    [USPrice]                           VARCHAR (255) NULL,
    [UKPrice]                           VARCHAR (255) NULL,
    [PromotionsEligible]                VARCHAR (255) NULL,
    [PromotionsDiscountDetails]         VARCHAR (255) NULL,
    [PromotionsEffectiveDateRange]      VARCHAR (255) NULL,
    [SBEProduct]                        VARCHAR (255) NULL,
    [EUPrice]                           VARCHAR (255) NULL,
    [SupportContractItem]               VARCHAR (255) NULL,
    [AUPrice]                           VARCHAR (255) NULL,
    [NoPhoneListPrice]                  VARCHAR (255) NULL,
    [ShoreTelCostPercentofListPrice]    VARCHAR (255) CONSTRAINT [DF_ArenaItemTrkSF_ShoreTelCostPercentofListPrice] DEFAULT ((0)) NULL,
    [CAPrice]                           VARCHAR (255) NULL,
    [CountriesIncluded]                 VARCHAR (MAX) NULL,
    [OrderableSystemsApplicable]        VARCHAR (255) NULL,
    [TargetReleaseDate]                 VARCHAR (255) NULL,
    [SerializedProduct]                 VARCHAR (255) NULL,
    [SingleUnitWeight]                  VARCHAR (255) NULL,
    [VoltageInput]                      VARCHAR (255) NULL,
    [Stockable]                         VARCHAR (255) NULL,
    [TieredPricingApplicable]           VARCHAR (255) NULL,
    [NumberofLithiumBatteries]          VARCHAR (255) NULL,
    [Battery]                           VARCHAR (255) NULL,
    [BatteryWattHours]                  VARCHAR (255) NULL,
    [CountryofOrigin]                   VARCHAR (255) NULL,
    [DiscountCategory]                  VARCHAR (255) NULL,
    [ECCN]                              VARCHAR (255) NULL,
    [GSAEligible]                       VARCHAR (255) NULL,
    [GSASIN]                            VARCHAR (255) NULL,
    [HWOnlyPercentofPrice]              VARCHAR (255) CONSTRAINT [DF_ArenaItemTrkSF_HWOnlyPercentofPrice] DEFAULT ((0)) NULL,
    [IncludeExcludePartners]            VARCHAR (255) NULL,
    [MaxAltitude]                       VARCHAR (255) NULL,
    [OperatingRelativeHumidity]         VARCHAR (255) NULL,
    [OperatingTemp]                     VARCHAR (255) NULL,
    [PartException]                     VARCHAR (255) NULL,
    [PartExceptionNotes]                VARCHAR (255) NULL,
    [PartnersAffected]                  VARCHAR (MAX) NULL,
    [PowerConsumption]                  VARCHAR (255) NULL,
    [PricingSupportforBundles]          VARCHAR (255) NULL,
    [ProductBundle]                     VARCHAR (255) NULL,
    [ShippingHeight]                    VARCHAR (255) NULL,
    [ShippingLength]                    VARCHAR (255) NULL,
    [ShippingWidth]                     VARCHAR (255) NULL,
    [SupportType]                       VARCHAR (255) NULL,
    [SWOnlyPercentofPrice]              VARCHAR (255) CONSTRAINT [DF_ArenaItemTrkSF_SWOnlyPercentofPrice] DEFAULT ((0)) NULL,
    [VADNotificationDate]               VARCHAR (255) NULL,
    [AnnualBillingTerm]                 VARCHAR (255) NULL,
    [PhonePercentofPrice]               VARCHAR (255) CONSTRAINT [DF_ArenaItemTrkSF_PhonePercentofPrice] DEFAULT ((0)) NULL,
    [StatementofWork]                   VARCHAR (255) NULL,
    [ControlledRelease]                 VARCHAR (255) NULL,
    [ItemType]                          VARCHAR (255) NULL,
    [ItemSubtype]                       VARCHAR (255) NULL,
    [HTS]                               VARCHAR (255) NULL,
    [MarketFamily]                      VARCHAR (255) NULL,
    [GSADiscount]                       VARCHAR (255) NULL,
    [CustomerSupportRate]               VARCHAR (255) CONSTRAINT [DF_ArenaItemTrkSF_CustomerSupportRate] DEFAULT ((0)) NULL,
    [DependencyCode]                    VARCHAR (255) NULL,
    [DependencyCodeDescription]         VARCHAR (255) NULL,
    [SupportTerm]                       VARCHAR (255) NULL,
    [MultiUnitCount]                    VARCHAR (255) NULL,
    [SKULifecycle]                      VARCHAR (255) NULL,
    [ProfitCenterNumberandDescription]  VARCHAR (255) NULL,
    [GMFamily]                          VARCHAR (255) NULL,
    [ItemGroup]                         VARCHAR (255) NULL,
    [ItemForm]                          VARCHAR (255) NULL,
    [CloudItemID]                       VARCHAR (255) NULL,
    [SystemsAffectedbyChange]           VARCHAR (255) NULL,
    [MRR]                               VARCHAR (255) NULL,
    [NRR]                               VARCHAR (255) NULL,
    [ShoreTelReplaceableUnit]           VARCHAR (255) NULL,
    [ShowMonthlyOnInvoice]              VARCHAR (255) NULL,
    [ShowSetupOnInvoice]                VARCHAR (255) NULL,
    [VendorReplaceableUnit]             VARCHAR (255) NULL,
    [IsAutoProvisioned]                 VARCHAR (255) NULL,
    [IsSpecialWorkflow]                 VARCHAR (255) NULL,
    [VisibleToUser]                     VARCHAR (255) NULL,
    [PromotionsCustomerTypeforDiscount] VARCHAR (255) NULL,
    [BigMachinesPartNumber]             VARCHAR (255) NULL,
    [CustomPricing]                     VARCHAR (255) NULL,
    [ConnectSKU]                        VARCHAR (255) NULL,
    [IsBundleOnly]                      VARCHAR (255) NULL,
    [IsSinglePerAccount]                VARCHAR (255) NULL,
    [PlatformType]                      VARCHAR (255) NULL,
    [ShortName]                         VARCHAR (255) NULL,
    [SyncProductStatus]                 CHAR (1)      CONSTRAINT [DF_ArenaItemTrkSF_SyncStatus] DEFAULT ('N') NULL,
    [SyncEcoStatus]                     CHAR (1)      CONSTRAINT [DF_ArenaItemTrkSF_SyncEcoStatus] DEFAULT ('N') NULL,
    [SyncQmsModStatus]                  CHAR (1)      CONSTRAINT [DF_ArenaItemTrkSF_SyncQmsModStatus] DEFAULT ('N') NULL,
    [SyncQmsDelStatus]                  CHAR (1)      NULL,
    [SyncProdErrorMsg]                  VARCHAR (MAX) NULL,
    [SyncEcoErrorMsg]                   VARCHAR (MAX) NULL,
    [SyncQmsModErrorMsg]                VARCHAR (MAX) NULL,
    [QmsLastModDate]                    DATETIME      NULL,
    [ProductId]                         VARCHAR (255) NULL,
    [PricebookEntryId]                  VARCHAR (255) NULL,
    [EcoRequestId]                      VARCHAR (255) NULL,
    [BMPartsStatus]                     VARCHAR (10)  NULL,
    [BMPartsType]                       VARCHAR (10)  NULL,
    [BMPartsErrorMsg]                   VARCHAR (MAX) NULL,
    [BMPartsLastUpdate]                 DATETIME      NULL,
    [PBE_USD_Id]                        VARCHAR (50)  NULL,
    [PBE_GBP_Id]                        VARCHAR (50)  NULL,
    [PBE_EUR_Id]                        VARCHAR (50)  NULL,
    [PBE_CAD_Id]                        VARCHAR (50)  NULL,
    [PBE_AUD_Id]                        VARCHAR (50)  NULL,
    CONSTRAINT [PK_ArenaItemTrkSF_1] PRIMARY KEY CLUSTERED ([guid] ASC)
);

