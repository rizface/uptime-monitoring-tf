# Description
This is repo is used to provision resource for https://github.com/rizface/uptime-monitoring. after the resources is provisioned then the configuration will be done using this repo https://github.com/rizface/uptime-monitoring-playbook

# How To

## Generate Service Account
Open this page https://console.cloud.google.com/iam-admin/serviceaccounts. you can create new service account or use the existing one.
After that you need to generate service account json file

## Run This Repo

```
terraform init
terraform plan
terraform apply
```