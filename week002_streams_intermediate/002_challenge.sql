
USE ROLE SYSADMIN;

-- Default values
-- MAX_CLUSTER = 1
-- SCALING_POLICY = STANDARD
CREATE OR REPLACE WAREHOUSE ffc_xs
WITH 
WAREHOUSE_SIZE = XSMALL
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = 'Frosty Friday Challenge Warehouse with fixed size XSMALL';

USE WAREHOUSE ffc_xs;
CREATE OR REPLACE DATABASE FROSTY_FRIDAY;
CREATE OR REPLACE SCHEMA STAGE;
USE FROSTY_FRIDAY.STAGE;

CREATE OR REPLACE STAGE src_ffc_002
    URL = 's3://frostyfridaychallenges/challenge_2/'
    COMMENT = 'External Stage to S3 Bucket for the Frosty Friday Challenge Week 2'
    FILE_FORMAT = (TYPE = PARQUET)
;

-- Explore Parquet File
LIST @src_ffc_002 PATTERN = '.*parquet';

CREATE OR REPLACE EXTERNAL TABLE ext_ffc_002
LOCATION = @src_ffc_002
PATTERN = '.*parquet'
FILE_FORMAT = (TYPE = PARQUET);

-- Show unique column names across all entries
SELECT ARRAY_UNION_AGG(OBJECT_KEYS($1))
FROM ext_ffc_002
;

/* 
Output 
["city","country","country_code","dept","education","email","employee_id","first_name","job_title","last_name","payroll_iban","postcode","street_name","street_num","time_zone","title","suffix"]
*/

-- All table columns are defined as varchar so that future loading processes to this stage aren't interrupted by any errors in values
-- Additionally errornous rows can be identified afterwards and collected for analysis

CREATE OR REPLACE TABLE stg_ffc_002
(
city VARCHAR
,country VARCHAR
,country_code VARCHAR
,dept VARCHAR
,education VARCHAR
,email VARCHAR
,employee_id VARCHAR
,first_name VARCHAR
,job_title VARCHAR
,last_name VARCHAR
,payroll_iban VARCHAR
,postcode VARCHAR
,street_name VARCHAR
,street_num VARCHAR
,time_zone VARCHAR
,title VARCHAR
,suffix VARCHAR
)
;

COPY INTO stg_ffc_002 FROM @src_ffc_002
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE 
;

SELECT *
FROM stg_ffc_002;