########################################
#                 ICMP                 #
#        permit ping from anywhere     #
########################################
resource "openstack_networking_secgroup_v2" "secgroup_icmp" {
  name        = "secgroup_icmp"
  description = "Allow ping from anywhere"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_icmp.id}"
}

########################################
#                  SSH                 #
#         permit ssh from anywhere     #
########################################
resource "openstack_networking_secgroup_v2" "secgroup_ssh" {
  name        = "secgroup_ssh"
  description = "Allow ssh"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_ssh.id}"
}
########################################
#             ssh доступ               #
#           с любых адресов            #
########################################

########################################
#          WEB from ANY                #
#    permit http/https from ANY        #
########################################

resource "openstack_networking_secgroup_v2" "secgroup_web_all" {
  name        = "secgroup_web_all"
  description = "Allow http/https for all incoming from anywhere"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_http_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web_all.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_https_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_web_all.id}"
}
########################################
#      Веб доступ к http/https         #
#           с любых адресов            #
########################################

######################################################
#               Netdata from local networks          #
#         permit access to Netdata interface         #
######################################################
resource "openstack_networking_secgroup_v2" "secgroup_netdata_local" {
  name        = "secgroup_netdata_local"
  description = "Allow Netdata from local networks"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_office" {
  description       = "Allow Netdata from office"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "${var.iprange_office}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_dc" {
  description       = "Allow Netdata from datacenter"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "${var.iprange_dc}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}
######################################################
#     Доступ к веб-интерфейсу мониторинга Netdata    #
#           из локальных подсетей                    #
######################################################

######################################################
#               Dropbear SSH from ANY                #
#         custom ssh port to unlock luks partition   #
######################################################
resource "openstack_networking_secgroup_v2" "secgroup_dropbear" {
  name        = "secgroup_dropbear"
  description = "Allow custom dropbear ssh access"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_dropbear" {
  description       = "Allow dropbear ssh access"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2242
  port_range_max    = 2242
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_dropbear.id}"
}
#######################################################
#     Порт для доступа по кастомному порту ssh        #
# с любого адреса. Для разблокировки luks хранилища.  #
#######################################################

######################################################
#               Netdata from local networks          #
#         permit access to Netdata webinterface      #
######################################################
resource "openstack_networking_secgroup_v2" "secgroup_netdata_local" {
  name        = "secgroup_netdata_local"
  description = "Allow Netdata from local networks"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_office" {
  description       = "Allow Netdata from office"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "172.22.1.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_vpn" {
  description       = "Allow Netdata from vpn datacenter users"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "172.22.7.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_dc" {
  description       = "Allow Netdata from datacenter"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "172.22.8.0/21"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_netdata_cloudinfra" {
  description       = "Allow Netdata from cloud infra prod subnet"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 19999
  port_range_max    = 19999
  remote_ip_prefix  = "10.80.80.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_netdata_local.id}"
}
#################################################
#      Доступ к веб-интерфейсу Netdata          #
#            из локальных подсетей              #
#################################################