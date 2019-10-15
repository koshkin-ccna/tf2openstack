######################################
#         networking section         #
######################################

# Router
# Создаем роутер
resource "openstack_networking_router_v2" "infra_router" {
  name = "infra_router"
}

#Router interface for PROD network
#Создаем интерфейс роутера в первой подсети
resource "openstack_networking_router_interface_v2" "infra_router_int_0" {
  router_id = "${openstack_networking_router_v2.infra_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.infra_subnet_0.id}"
}

# Router interface for TEST network
# Создаем интерфейс роутера во второй подсети
resource "openstack_networking_router_interface_v2" "infra_router_int_1" {
  router_id = "${openstack_networking_router_v2.infra_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.infra_subnet_1.id}"
}

# Define public ip addresses pool
# Резервируем публичные ip адреса
resource "openstack_networking_floatingip_v2" "vm_floating_ip" {
  pool = "ext-net"
}

# Create network for infra resources
# Создаем сеть для ресурсов инфраструктуры
resource "openstack_networking_network_v2" "cloud_infra_network" {
  name           = "cloud_infra_network"
  admin_state_up = "true"
}

# Create subnet for prod infrastructure
# Cоздаем подсеть для прода
resource "openstack_networking_subnet_v2" "infra_subnet_0" {
  name       = "infra_subnet_0"
  description = "subnet for PROD infrastructure"
  network_id = "${openstack_networking_network_v2.cloud_infra_network.id}"
  cidr       = "10.80.80.0/24"
  ip_version = 4
  dns_nameservers = ["77.88.8.2","77.88.8.88"]
}

# Create subnet for test infrastructure
# Cоздаем подсеть для тестового контура
resource "openstack_networking_subnet_v2" "infra_subnet_1" {
  name       = "infra_subnet_1"
  description = "subnet for test infrastructure"    
  network_id = "${openstack_networking_network_v2.cloud_infra_network.id}"
  cidr       = "10.80.81.0/24"
  ip_version = 4
  dns_nameservers = ["77.88.8.2","77.88.8.88"]
}