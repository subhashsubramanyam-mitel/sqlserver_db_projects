



/* Change Log: 5/25/2018, added 10 digits to avoid numbers with leading zeros) 
               7/18/2018, Rank filter is causing problems for Cube. Decided to Materialize the view. 
*/

CREATE VIEW [provision].[VwUniqueTn]
AS
SELECT     * from provision.MatVw_UniqueTn_base





