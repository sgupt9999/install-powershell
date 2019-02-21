## This is the file to be used to create powershell lambda function
## Need to enter credentials in defaultCreds



#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.450.0'}
$queryString = "select * from misc.holiday_schedule;";
    #$queryString

$target = "production";
    #$creds.$target.user;
#endregion

$date = Get-Date -format "yyyyMMdd_hhmmss"
$desc = "postgres-query-app: " + $date
$desc

#region creds
$defaultCreds = '{
    "production" : {
        "server": "",
        "port": "5432",
        "database": "",
        "user": "",
        "password": ""
    }
}';
#endregion

#region connection
#convert the $defaultCreds to an object
    $creds = ConvertFrom-Json -InputObject $defaultCreds;
    #$creds.production.user

# Format the json so we can use it in the connection string
    $server = $creds.$target.server.ToString();
    $port = $creds.$target.port.ToString();
    $database = $creds.$target.database.ToString();
    $user = $creds.$target.user.ToString();
    $password = $creds.$target.password.ToString();
    $driver = "psqlodbc"

$pgConn = New-Object System.Data.Odbc.OdbcConnection;
$pgConnectionString = "Driver={PostgreSQL};Server=$server;Port=$port;Database=$database;Uid=$user;Pwd=$password;"
#$pgConnectionString = "Driver=$driver;Server=$server;Port=$port;Database=$database;Uid=$user;Pwd=$password;"
$pgConn.ConnectionString = $pgConnectionString;
#endregion


try {
    $pgConn.Open()
    $DBCmd = $pgConn.CreateCommand();
    $DBCmd.CommandText = $queryString
    $reader = $DBCmd.ExecuteReader();
    $DataTable = New-Object System.Data.DataTable
    
    $connectionTime = measure-command {$DataTable.Load($reader)};
    #$connectionTime = measure-command {$DataTable.Load($reader)};

    $Result = @{
        Connection = "Successful"
        ElapsedTime = $connectionTime.TotalSeconds
        Server = $server
        Database = $database
        User = $user
        QueryResults = $DataTable.Rows
    }
    
}
# exceptions will be raised if the database connection failed.
catch {
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    #$ErrorMessage
    #$FailedItem

    $Result = @{
        Connection = "Failed"
        ElapsedTime = $connectionTime.TotalSeconds
        Server = $server
        Database = $database
        User = $user
        Error = $ErrorMessage
        FailedItem = $FailedItem
    }
}
finally{
    # close the database connection
    $pgConn.Close()
    #return the results as an object
    $outputObject = New-Object -Property $Result -TypeName psobject
    write-output $outputObject 
}

