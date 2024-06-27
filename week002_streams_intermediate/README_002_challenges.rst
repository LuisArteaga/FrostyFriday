A stakeholder in the HR department wants to do some change-tracking but is concerned that the stream which was created for them gives them too much info they don’t care about.

Load in the parquet data and transform it into a table, then create a stream that will only show us changes to the DEPT and JOB_TITLE columns. 

You can find the parquet data here: https://frostyfridaychallenges.s3.eu-west-1.amazonaws.com/challenge_2/employees.parquet

Execute the following commands:

UPDATE <table_name> SET COUNTRY = 'Japan' WHERE EMPLOYEE_ID = 8;
UPDATE <table_name> SET LAST_NAME = 'Forester' WHERE EMPLOYEE_ID = 22;
UPDATE <table_name> SET DEPT = 'Marketing' WHERE EMPLOYEE_ID = 25;
UPDATE <table_name> SET TITLE = 'Ms' WHERE EMPLOYEE_ID = 32;
UPDATE <table_name> SET JOB_TITLE = 'Senior Financial Analyst' WHERE EMPLOYEE_ID = 68

The result should look like this:
image:: images/End-Product-2048x349.png
:width: 300

