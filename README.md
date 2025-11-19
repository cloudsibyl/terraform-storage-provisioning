# snowflake-data-collector
Snowflake Data Collector


## Optionally use Terraform to create storage on AWS, Azure or GCP

## Authentication Methods Used

| Cloud Providers | Storage Name | Write Authentication Method | Read Authentication Method |
| :-------------: | :-------------: | :--------------------: | :----------------------: |
| [AWS](#creating-s3-bucket-on-aws)  | S3 Bucket | IAM user |  Assumed IAM role |
| [Azure](#creating-blob-storage-container-on-azure)   | Container inside blob storage | TBD |  TBD | 
| [GCP](#creating-gcs-bucket-on-gcp) | GCS Bucket | TBD |  TBD |

### Creating S3 bucket on AWS:


1. Log in to your AWS Console and open CloudShell

2. Clone this repository in current or desired directory:

```bash
git clone https://github.com/cloudsibyl/terraform-storage-provisioning.git
```

3. Go to the terraform for aws directory:
```bash
cd terraform-storage-provisionning/aws-s3-bucket
```

4. Install Terraform if not installed yet
```bash
make init
```
5. Add your information in terraform.tfvars file:
ctrl+o to write out, enter to save and ctrl+x to exit
```bash
nano terraform.tfvars
```

6. Create storage instance and grand read and write access to Snowflake:
```bash
make snowflake
```

7. Grant read access to CloudSibyl:
```bash
make cloudsibyl
```

8. Retrieve credentials
You should be able to see the generated credentials in
```bash
./aws-s3-bucket/cloudsibyl_role_info.txt
./aws-s3-bucket/snowflake_credentials.txt
```


### Creating blob storage container on Azure:


### Creating GCS bucket on GCP: