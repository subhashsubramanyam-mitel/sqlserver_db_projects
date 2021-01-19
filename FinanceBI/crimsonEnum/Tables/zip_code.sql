CREATE TABLE [crimsonEnum].[zip_code] (
    [state_abbrev] NVARCHAR (255) NOT NULL,
    [county]       NVARCHAR (255) NOT NULL,
    [city]         NVARCHAR (255) NOT NULL,
    [zipcode]      INT            NOT NULL,
    [state_fips]   NVARCHAR (2)   NOT NULL,
    [county_fips]  NVARCHAR (3)   NOT NULL
);

