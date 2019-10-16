# CENTOS CLOUD IMAGE
# Downloads image from official CentOS repo
# Uploads image to openstack images storage
# Defines optimized parameters for the image
resource "openstack_images_image_v2" "centos1907cloud" {
  name             = "centos1907cloud"
  # Terraform will cache image from http://cloud.centos.org/centos/7/images/
  # locally at .terraform/image_cache/*.img 
  image_source_url = "http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
  # https://docs.openstack.org/glance/latest/admin/useful-image-properties.html
  # https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/9/html/command-line_interface_reference_guide/glanceclient_commands#glance-property
  # https://www.redhat.com/en/blog/9-tips-properly-configure-your-openstack-instance
  properties = {
    architecture = "x86_64"
    os_type = "linux"
    os_distro = "centos"
    os_version = "7.6"
    os_require_quiesce = "yes"  # Accept requests to freeze/thaw filesystems
    hw_qemu_guest_agent = "yes" # Create the needed device to allow the guest agent to run
    hw_watchdog_action = "reset" # watchdog service default action
    hw_vif_multiqueue_enabled = "true" # VirtIO Multiqueuing
    hw_scsi_model = "virtio-scsi" # provides improved scalability and performance
  }
}

#UBUNTU MATE ISO IMAGE
# Downloads ISO image form official ubuntu repo
# Uploads image to openstack images storage
# This is a bootable live iso
resource "openstack_images_image_v2" "ubuntu-18043-mate-amd64-iso" {
  name             = "ubuntu-18043-mate-amd64-iso" 
  image_source_url = "http://cdimage.ubuntu.com/ubuntu-mate/releases/18.04.3/release/ubuntu-mate-18.04.3-desktop-amd64.iso"
  container_format = "bare"
  disk_format      = "iso"
  visibility       = "private"
  properties = {
    hw_disk_bus = "ide"
    hw_cdrom_bus = "ide"
  }
}

# Create image fromcli
# openstack image create --private --container-format bare \
# --disk-format iso --property hw_cdrom_bus=ide --property \
# hw_disk_bus=ide --file ~/Downloads/ubuntu-18.04.3-server-amd64.iso \
# ubuntu-18043-server-amd64-iso
#
#openstack image set --property hw_cdrom_bus=ide --property hw_disk_bus=ide ubuntu-18043-mate-amd64-iso
#https://ask.openstack.org/en/question/105467/attach-iso-image-as-cdrom-to-windows-instance/