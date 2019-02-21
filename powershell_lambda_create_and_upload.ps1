$publishPSLambdaParams = @{
	Name = 'db'
	ScriptPath = './db_lambda_1.ps1'
	Region = 'us-west-2'
	IAMRoleArn = 'lambda-full-role'
}

Publish-AWSPowerShellLambda @publishPSLambdaParams


## Sometimes the first method doesnt work, so create a zip file and load it to S3
##New-AWSPowerShellLambdaPackage -ScriptPath ./test.ps1 -OutputPackage fileUploader.zip


