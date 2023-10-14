
USE ROLE SYSADMIN;
CREATE OR REPLACE DATABASE FROSTY_FRIDAY;
CREATE OR REPLACE SCHEMA STAGE;
USE FROSTY_FRIDAY.STAGE;

CREATE OR REPLACE STAGE src_ffc_001
    URL = 's3://frostyfridaychallenges/challenge_1/'
    COMMENT = 'External Stage to S3 Bucket for the Frosty Friday Challenge Week 1'
    FILE_FORMAT = (TYPE = CSV)
;

-- LIST @src_ffc_001;

CREATE OR REPLACE TABLE stg_ffc_001
(VALUE1 varchar);

COPY INTO stg_ffc_001 FROM @src_ffc_001 
--VALIDATION_MODE = RETURN_ALL_ERRORS
;
