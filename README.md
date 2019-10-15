# tf2openstack

 This is a repo with the Terraform project for the Openstack provider.

## provisions infrastructure resources

### PREREQUISITES

+ Istall Terraform v0.12.5 or higher (provider.openstack: version = "~> 1.20") on your admin machine
+ Clone this repo to local directory
+ Download OpenStack RC File v3 from Horizon web interface
+ Get your credentials from downloaded file `egrep "OS_USERNAME=|OS_PROJECT_NAME=|OS_USER_DOMAIN_NAME=|OS_PROJECT_DOMAIN_ID=" openrc.sh`

### Prepare override.tf file

```yaml
provider "openstack" {
  user_name = "your@email.cz"
  password = "your-cleartext-password"
  project_domain_id = "lookup-your-openrc.sh-from-horizon"
}
```

### HOW TO USE

Commands must be executed in a current directory with .tf files
WARNING: use `destroy` with caution, it will destroy all resourses irreversably.

```console
foo@bar:~$ terraform --version
foo@bar:~$ terraform init
foo@bar:~$ terraform plan
foo@bar:~$ terraform apply
foo@bar:~$ terraform apply --target=openstack_compute_instance_v2.cloud-infra-awx
foo@bar:~$ terraform destroy --target=openstack_compute_instance_v2.cloud-infra-log
```

### IMPORTANT NOTES

DO NOT CHANGE ANYTHING MANUALLY using Horizon or openstack-cli!
*ANY* INFRASTRUCTURE CHANGES MUST BE WRITTEN HERE!

TF will return some info about VM after successful provisioning. Use provided IP address to ssh into a newly created VM or copy info to your ansible inventory file.
