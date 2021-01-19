﻿CREATE TABLE [dbo].[POS_EMEA] (
    [ReportDate]                           DATETIME       NOT NULL,
    [Id]                                   INT            NOT NULL,
    [Created]                              DATETIME       NOT NULL,
    [ST_POS_TXN_ID]                        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [INOW_DataFile_ID]                     NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TransactionNumber]                    NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [LineNumber]                           VARCHAR (5)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SKU]                                  NVARCHAR (53)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Quantity]                             FLOAT (53)     NULL,
    [Informational]                        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Serial_Number]                        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAR_PO]                               NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAD_SO]                               NVARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAD_Ship_Date]                        DATETIME       NULL,
    [VAR_ID]                               NVARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Placeholder]                          NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sold_To_INOW_ID]                      NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_Contact_Name]            NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_Contact_Phone_Number]    NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_Contact_EMail]           NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_IT_Contact_Name]         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_IT_Contact_Phone_Number] NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_IT_Contact_EMail]        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Transaction_Type]                     NVARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_Lead_ID]                 NVARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [End_Customer_ID]                      NVARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAD_PO]                               NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DiscountID_1]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DiscountAmount_1]                     FLOAT (53)     NULL,
    [DiscountID_2]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DiscountAmount_2]                     FLOAT (53)     NULL,
    [DiscountID_3]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DiscountAmount_3]                     FLOAT (53)     NULL,
    [Description]                          NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAD_PurchasePrice_Reported]           FLOAT (53)     NULL,
    [VAD_ExtPurchasePrice_Reported]        FLOAT (53)     NULL,
    [VAD_Net_Price]                        FLOAT (53)     NULL,
    [VAD_Net_Price_Ext]                    FLOAT (53)     NULL,
    [Currency]                             NVARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [List_Price_Reported]                  FLOAT (53)     NULL,
    [VAD_ID]                               NVARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Matched_SKU]                          NVARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Matched_List_Price]                   FLOAT (53)     NULL,
    [VAD_PurchasePrice_Calculated]         FLOAT (53)     NULL,
    [Applied_Discount_Program]             NVARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VAD_Net_Price_Calculated]             FLOAT (53)     NULL,
    [DELETED]                              FLOAT (53)     NULL,
    [REPORT_DATE]                          VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FileName]                             VARCHAR (100)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [DropShip]                             VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCusPo]                             VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Duplicate]                            VARCHAR (15)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ship_to_name]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ship_to_id]                           NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [bill_to_name]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [bill_to_id]                           NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [vad_invoice_number]                   NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [original_tran_num]                    NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_name]                             NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_address1]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_address2]                         NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_city]                             NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_state]                            NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_postal]                           NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [var_country]                          NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_name]                        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_address1]                    NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_address2]                    NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_city]                        NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_state]                       NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_postal]                      NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [customer_country]                     NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Updated]                              VARCHAR (15)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[POS_EMEA] TO [POS_EMEA]
    AS [dbo];

