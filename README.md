# CI/CD with GitHub Actions and AWS

This is used to practice terraform to create AWS resources and uploaded tfstate files to S3

How to set up 
[OpenID Connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
for AWS. Remember to set up the necessary permissions depending on which AWS services used, otherwise your GitHub Actions workflow will fail

Retrieving object from S3 can be done either way with `s3api get-object` or `s3 cp`

`aws s3api get-object --bucket bucket/name --key path/to/object downloaded/object`

`aws s3 cp s3-URI downloaded/object`

Since I used base64 to encode before uploading to S3, I had to decode with base64 after I retrieved the S3 object

`base64 -d downloaded/object > decoded/file`