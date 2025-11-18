# snowflake-data-collector
Snowflake Data Collector

## Optionally use Terraform to create storage on AWS, Azure or GCP

### Creating S3 bucket on AWS:


1. Install Terraform

2. Go to the terraform for aws directory:
```bash
cd terraform-storage-provisionning/aws-s3-bucket
```

3. Initialize terraform here:
```bash
terraform init
```

4. Run Terraform with desired organization name and storage regions:

**NB: Make sure you are logged in to your AWS account or declared relevant environment variables.**
```bash
terraform apply \
-var="org_name=<your-organization-name>" \
-var="aws_region=<region-of-S3-bucket>" \
-var="cloudsibyl_external_id=<your-external-id-from-cloudsibyl>"
```

5. Retrieve credentials
You should be able to see the generated credentials in
```bash
./aws-s3-bucket/cloudsibyl_role_info.txt
./aws-s3-bucket/snowflake_credentials.txt
```


### Creating blob storage container on Azure:


### Creating GCS bucket on GCP:


## Authentication Methods Used

| Cloud Providers | Storage Name | Write Authentication Method | Read Authentication Method |
| :-------------: | :-------------: | :--------------------: | :----------------------: |
| AWS     | S3 Bucket | IAM user |  Assumed IAM role |
| Azure   | Container inside blob storage | TBD |  TBD | 
| GCP     | GCS Bucket | TBD |  TBD |