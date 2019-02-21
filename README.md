**Setup a powershell environment to be able to upload lambda functions**

**Steps**
* **Run powershell_lambda_setup.sh**
    * This installs powershell core and dotnet
* **Run unixodbc.sh**
    * This installs unixODBC
* **Run postgresql.sh**
    * This installs postgreSQL ODBC drivers
* Check powershell_env.ps1 to add accessKey and secretKey or not if the EC2 instance has the correct role
* **There are three scripts**
    * **test.ps1** - Creates a simple "Hello World" lambda function
    * **db_no_lambda.ps1** - Connects to an existing postgres db from powershell (need to provide credentials)
    * **db_lambda_1.ps1** - Creates a lambda function for connecting to postgres (cred required and currently not working)
* **Update powershell_lambda_create_and_upload.ps1**
    * Name - Lambda function Name
    * ScriptPath = Lambda function ScriptPath
    * Region = AWS Region
    * IAMRoleArn = Lambda role
* **sudo pwsh**
    * To enter the powershell prompt
    * ./powershell_env.ps1
        * This will initialize the environment settings
    * ./powershell_lambda_create_and_upload.ps1
        * depending on the file selected this will create a "Hello World" or a postgres connecting Lambda function
    * OR ./db_no_lambda.ps1 to connect to postgres directly from powershell

