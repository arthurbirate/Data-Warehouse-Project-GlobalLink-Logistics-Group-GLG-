/* ==========================================================
   Project: GlobalLink Logistics Data Warehouse
   Purpose: Create database and Medallion Architecture schemas
   Author: Your Name
   ========================================================== */

USE master;
GO

/* ----------------------------------------------------------
   Drop existing database if it already exists
   This allows the script to be rerun multiple times
   ---------------------------------------------------------- */
IF EXISTS (
    SELECT name
    FROM sys.databases
    WHERE name = 'Globallink_DB'
)
BEGIN
    ALTER DATABASE Globallink_DB
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE Globallink_DB;
END
GO

/* ----------------------------------------------------------
   Create the main database
   ---------------------------------------------------------- */
CREATE DATABASE Globallink_DB;
GO

/* ----------------------------------------------------------
   Switch context to the new database
   ---------------------------------------------------------- */
USE Globallink_DB;
GO

/* ==========================================================
   Bronze Layer
   Purpose:
   - Store raw source data exactly as received
   - No transformations
   - No cleaning
   - Serves as the audit/source layer
   ========================================================== */
CREATE SCHEMA bronze;
GO

/* ==========================================================
   Silver Layer
   Purpose:
   - Store cleaned and standardized data
   - Remove duplicates
   - Apply validation rules
   - Standardize formats
   - Prepare data for business modeling
   ========================================================== */
CREATE SCHEMA silver;
GO

/* ==========================================================
   Gold Layer
   Purpose:
   - Business-ready analytical layer
   - Fact tables
   - Dimension tables
   - KPIs and reporting datasets
   - Consumed by Power BI and analysts
   ========================================================== */
CREATE SCHEMA gold;
GO

/* ----------------------------------------------------------
   Verify schema creation
   ---------------------------------------------------------- */
SELECT
    schema_id,
    name AS schema_name
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold');
GO
