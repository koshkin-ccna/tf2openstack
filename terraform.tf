
# Use override.tf to store your credentials
# See variables.tf to find credentials
# Define your provider credentials
provider "openstack" {
  user_name = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password = "${var.password}"
  auth_url = "https://your.cloud.provider.url.cz:35357/v3/"
  user_domain_name = "${var.user_domain_name}"
  project_domain_id = "${var.project_domain_id}"
}

# public key for ssh access
resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "my-cloud-key"
  public_key = "${var.publickey}"
}