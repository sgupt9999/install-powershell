Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted 
Install-Module AWSPowerShell -Scope CurrentUser
Install-Module AWSLambdaPSCore -Scope CurrentUser
Install-Module AWsPowerShell.NetCore -Scope CurrentUser
Import-Module AWSPowerShell -Force
Import-Module AWSLambdaPSCore -Force
Initialize-AWSDefaultConfiguration -Region us-west-2

## If using accessKey and secretKey
#$accessKey = ''
#$secretKey = ''
#Initialize-AWSDefaultConfiguration -AccessKey $accessKey -SecretKey $secretKey -Region us-west-2

#Get-AWSPowerShellLambdaTemplate
