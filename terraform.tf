
# Use override.tf to store your credentials
# Используй override.tf для храниения реквизитов доступа
# See variables.tf to find credentials
# Описание переменных смотри в файле variables.tf
# Define your provider credentials
# Здесь определены параметры доступа к облачному провайдеру
provider "openstack" {
  user_name = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password = "${var.password}"
  auth_url = "https://your.cloud.provider.url.cz:35357/v3/"
  user_domain_name = "${var.user_domain_name}"
  project_domain_id = "${var.project_domain_id}"
}

# public key for ssh access
# публичная часть ssh ключа для доступа к создаваемым виртуальным машинам
resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "my-cloud-key"
  public_key = "${var.publickey}"
}