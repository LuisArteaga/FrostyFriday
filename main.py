import os
from snowflake.core import Root
from snowflake.snowpark import Session

CONNECTION_PARAMETERS = {
    "account":  os.environ["SNOWFLAKE_ACCOUNT_DEMO"],
    "user": os.environ["SNOWFLAKE_USER_DEMO"],
    "password": os.environ["SNOWFLAKE_PASSWORD_DEMO"]
}

sessionBuilder = Session.builder

for key, value in CONNECTION_PARAMETERS.items():
    sessionBuilder.config(key, value)

sfSession = sessionBuilder.create()

# Can execute only one statement

with open("week000_setup/setup.sql", "r") as f:
    statement_count = f.read().count(';')
    print(sfSession.sql(f.read()).collect())
