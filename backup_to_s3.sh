#!/bin/bash
# Run locally from the unzipped project folder after replacing the values below.
# Requires AWS CLI configured with credentials allowed to upload to your bucket.
set -euo pipefail
BUCKET_NAME="REPLACE-WITH-YOUR-UNIQUE-S3-BUCKET-NAME"
aws s3 cp website/ "s3://${BUCKET_NAME}/website-backup/" --recursive
echo "Website backup uploaded to s3://${BUCKET_NAME}/website-backup/"
