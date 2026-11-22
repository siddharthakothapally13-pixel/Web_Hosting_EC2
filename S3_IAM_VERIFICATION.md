# S3 Backup Access and Download Verification

This document records the IAM-role and S3 verification completed for the UNLOX Cloud Computing minor project.

## Purpose

The project uses an EC2-hosted static website and an Amazon S3 bucket to keep private backup copies of the website files. A second EC2 instance, named `UNLOX-WEB-SERVER`, was configured to access the S3 backup using an attached IAM instance role.

## AWS resources involved

| Resource | Configuration |
|---|---|
| AWS Region | Asia Pacific (Sydney), `ap-southeast-2` |
| S3 bucket | `unlox-cloud-project-siddhartha-2026` |
| S3 backup prefix | `website-backup/` |
| Backup objects | `index.html`, `styles.css` |
| EC2 instance role | `instanceRole` |
| EC2 operating system | Amazon Linux 2023 |

## IAM role configuration

The IAM role `instanceRole` was attached to the second EC2 instance through **EC2 → Instances → Actions → Security → Modify IAM role**.

The instance obtains temporary AWS credentials through its attached IAM role. Therefore, access keys do not need to be stored on the EC2 instance and `aws configure` is not required for this role-based access.

The role's permissions must allow the required S3 operations on the project bucket:
- `s3:ListBucket` on the bucket ARN.
- `s3:GetObject` on objects under the `website-backup/` prefix.

If uploads from this instance are required in the future, grant only the additional object-write permissions needed for that workflow.

## Verification performed

Run the following commands after connecting to the second EC2 instance.

### 1. Confirm AWS CLI is installed

```bash
aws --version
```

The installed CLI was reported as AWS CLI version 2.38.0.

### 2. Confirm the instance is using its IAM role

```bash
aws sts get-caller-identity
```

The command succeeded and returned an assumed-role ARN for `instanceRole`, confirming that the instance was authenticated through the attached role.

### 3. List the S3 backup objects

```bash
aws s3 ls s3://unlox-cloud-project-siddhartha-2026/website-backup/
```

The successful listing showed:

| Object | Size |
|---|---:|
| `index.html` | 1,220 bytes |
| `styles.css` | 1,515 bytes |

### 4. Download a backup object from S3

```bash
mkdir -p ~/s3-test
aws s3 cp s3://unlox-cloud-project-siddhartha-2026/website-backup/index.html ~/s3-test/
```

The AWS CLI reported that the 1.2 KiB file download completed successfully.

### 5. Verify the downloaded file exists

```bash
ls -l ~/s3-test/
```

The output showed `index.html` in the local `s3-test` directory with a size of 1,220 bytes.

## Result

The S3 access and download test completed successfully:

- The second EC2 instance authenticated using its attached IAM role.
- The instance listed the website backup objects in the S3 bucket.
- The instance downloaded `index.html` from S3.
- The downloaded file was verified in the local directory.

This confirms the tested **EC2-to-S3 read and download path**. It does not by itself verify automated or scheduled backups, nor does it verify that this instance can upload objects.

## Security notes

- Do not store AWS access keys or secret keys on the EC2 instance.
- Do not commit private SSH keys (`.pem` files), AWS credentials, or session tokens to Git.
- Keep the S3 bucket private and retain S3 Block Public Access unless the project requirements explicitly say otherwise.
- Grant the IAM role only the S3 permissions required by the project.
