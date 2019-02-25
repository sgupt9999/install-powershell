## Can use this script to test postgres connectivity from Linux Powershell
## Need to enter all information in $defaultCreds 

#$queryString = "select * from misc.holiday_schedule;"
$queryString = "select * from test1;"
$queryString
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
    $creds.production.user

# Format the json so we can use it in the connection string
    $server = $creds.$target.server.ToString();
    $port = $creds.$target.port.ToString();
    $database = $creds.$target.database.ToString();
    $user = $creds.$target.user.ToString();
    $password = $creds.$target.password.ToString();

$pgConn = New-Object System.Data.Odbc.OdbcConnection;
$pgConnectionString = "Driver={PostgreSQL};Server=$server;Port=$port;Database=$database;Uid=$user;Pwd=$password;"
$pgConn.ConnectionString = $pgConnectionString;
#endregion
$pgConnectionString

$pgConn.Open()
$DBCmd = $pgConn.CreateCommand();
$DBCmd.CommandText = $queryString
$reader = $DBCmd.ExecuteReader();
$DataTable = New-Object System.Data.DataTable

$connectionTime = measure-command {$DataTable.Load($reader)};
#$connectionTime = measure-command {$DataTable.Load($reader)};

$DataTable

