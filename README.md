# UNLOX Cloud Computing Minor Project

## Static Website Hosting Using Amazon EC2 and Amazon S3 (Nginx)

This project demonstrates hosting a static website on an Amazon EC2
Linux instance using Nginx and storing backup copies of the website
files in Amazon S3.

## Project environment

  Item                Configuration
  ------------------- -------------------------------------------
  Cloud provider      Amazon Web Services (AWS)
  AWS Region          Asia Pacific (Sydney) -- `ap-southeast-2`
  EC2 instance name   `UNLOX-Cloud-Project`
  EC2 instance type   `t3.micro`
  Operating system    Amazon Linux 2023
  Web server          Nginx
  Website access      HTTP on TCP port 80
  S3 bucket           `unlox-cloud-project-siddhartha-2026`
  S3 backup prefix    `website-backup/`
  Backup files        `index.html`, `styles.css`

> **Instance type note:** The assignment specifies `t2.micro`. The
> deployed instance used `t3.micro` because `t2.micro` was unavailable
> under the account's current plan. Confirm with the instructor that
> this substitution is acceptable.

## Architecture

1.  A user opens the EC2 instance's public IPv4 address in a web
    browser.
2.  The EC2 security group permits HTTP traffic on TCP port 80.
3.  Nginx serves the static website files from `/usr/share/nginx/html/`.
4.  Website backup files are stored in the S3 bucket under
    `website-backup/`.

## Security group configuration

  ----------------------------------------------------------------------------
  Type          Protocol                   Port Source        Purpose
  ------------- ------------- ----------------- ------------- ----------------
  SSH           TCP                          22 Your current  Secure
                                                public IP     administrative
                                                `/32`         access

  HTTP          TCP                          80 `0.0.0.0/0`   Public website
                                                              access
  ----------------------------------------------------------------------------

Keep SSH restricted to your own current public IP address. Do not expose
SSH to `0.0.0.0/0`. If your public IP changes, update the SSH inbound
rule to the new address with `/32`.

## Deploying Nginx on Amazon Linux 2023

Connect from Windows PowerShell using your own downloaded key pair.
Replace the key path and public IP if they differ from your environment:

``` powershell
ssh -i "$env:USERPROFILE\.ssh\unlox-project-key.pem" ec2-user@13.210.144.238
```

Run these commands after connecting to the EC2 instance:

``` bash
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```

The Nginx service should show `active (running)`. If the status command
opens a pager, press `q` to exit.

Open the following address in a browser (use the instance's current
public IPv4 address):

``` text
http://13.210.144.238
```

## Website files

The website files are:

-   `website/index.html`
-   `website/styles.css`

To copy these files from the extracted project folder on Windows to the
EC2 instance, run the following from PowerShell in the folder containing
the `website` directory:

``` powershell
scp -i "$env:USERPROFILE\.ssh\unlox-project-key.pem" .\website\index.html .\website\styles.css ec2-user@13.210.144.238:/tmp/
```

Then, in the EC2 SSH session, install the files into the Nginx document
root:

``` bash
sudo cp /tmp/index.html /usr/share/nginx/html/index.html
sudo cp /tmp/styles.css /usr/share/nginx/html/styles.css
sudo chmod 644 /usr/share/nginx/html/index.html /usr/share/nginx/html/styles.css
```

Refresh the website in the browser to verify the custom UNLOX project
page is displayed.

## Amazon S3 backup

The project stores backup copies of the website files in this bucket:

``` text
s3://unlox-cloud-project-siddhartha-2026/website-backup/
```

The uploaded objects are:

-   `index.html`
-   `styles.css`

The AWS Console upload completed successfully. The S3 bucket is in
`ap-southeast-2` and **Block all public access is enabled**. The S3
objects are private backup copies; the website is served by Nginx on
EC2, not from a public S3 website endpoint.

To upload through the AWS Console:

1.  Open **Amazon S3 → Buckets**.
2.  Open `unlox-cloud-project-siddhartha-2026`.
3.  Open the `website-backup/` folder (create it if it does not exist).
4.  Choose **Upload → Add files**.
5.  Select `index.html` and `styles.css`.
6.  Complete the upload and verify that both objects appear in the
    object list.

## Evidence screenshots for submission

Include genuine screenshots captured from the AWS account. Do not use
mock-ups or fabricated console images.

1.  **EC2 instance:** instance name, `Running` state, and instance type.
2.  **Security group:** inbound rules showing SSH TCP 22 and HTTP TCP
    80.
3.  **Nginx website:** custom website loaded in a browser using the EC2
    public IPv4 address.
4.  **S3 bucket overview:** bucket name and AWS Region.
5.  **S3 uploaded objects:** `index.html` and `styles.css` inside
    `website-backup/`.

Optional additional evidence: the S3 Permissions page showing **Block
all public access: On**.

## Verification checklist

-   [ ] EC2 instance is running and status checks have passed.
-   [ ] Security group has SSH TCP 22 restricted to the current
    administrator IP.
-   [ ] Security group allows HTTP TCP 80 for website visitors.
-   [ ] Nginx is installed, enabled, and running.
-   [ ] The custom website loads over HTTP using the EC2 public IPv4
    address.
-   [ ] S3 contains `index.html` and `styles.css` in `website-backup/`.
-   [ ] S3 Block Public Access remains enabled for private backup
    storage.
-   [ ] All five genuine evidence screenshots are included in the
    report.

## Cost and cleanup

AWS resources may incur charges. The `t3.micro` instance may be billed
at the applicable On-Demand rate; Free Tier eligibility and pricing
depend on the account and current AWS terms. Check the AWS Billing
console and any budget alerts.

After assessment, if the resources are no longer required, stop or
terminate the EC2 instance as appropriate and remove unused resources.
Terminating an instance does not automatically delete every related
resource (for example, S3 buckets or separately retained storage). Check
the resources and billing implications before deleting anything.

## Important credential safety

-   Never commit or upload your `.pem` private key, AWS passwords,
    access keys, secret keys, or session tokens.
-   Do not share credentials in screenshots or chat.
-   Use an IAM identity with only the permissions required for the task.
-   Keep S3 backup objects private unless public access is explicitly
    required and approved.

## Project result

The custom static website was verified in a browser using the EC2 public
IPv4 address, and the website backup files `index.html` and `styles.css`
were verified in the S3 `website-backup/` prefix.
