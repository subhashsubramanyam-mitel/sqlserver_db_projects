CREATE TABLE [ldvs].[tenant_tn_ldvs] (
    [cluster_name]    VARCHAR (20)  NOT NULL,
    [tn]              VARCHAR (30)  NULL,
    [dn]              VARCHAR (50)  NULL,
    [tenant_id]       INT           NOT NULL,
    [tenant_name]     VARCHAR (500) NULL,
    [ldvs_hostname]   VARCHAR (100) NULL,
    [switch_hostname] VARCHAR (100) NULL,
    CONSTRAINT [AK1_tenant_tn_ldvs] UNIQUE NONCLUSTERED ([cluster_name] ASC, [tenant_id] ASC, [dn] ASC)
);

