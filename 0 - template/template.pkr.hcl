variable "password" {
  type    = string
  default = "supersecret"
}

variable "username" {
  type    = string
  default = "apiuser@pve"
}

source "proxmox-iso" "rocky-kickstart" {
  boot_command = ["<up><tab> ip=dhcp inst.cmdline inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.ks<enter>"]
  boot_wait    = "10s"
  disks {
    disk_size         = "32G"
    storage_pool      = "local-lvm"
    type              = "scsi"
  }
  http_directory           = "config"
  insecure_skip_tls_verify = true
  iso {
    iso_file                 = "local:iso/Rocky-10.1-x86_64-boot.iso"
    unmount                  = true
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  cpu_type             = "host"
  cores                = 2
  os                   = "l26"
  memory               = 2048


  node                 = "my-proxmox"
  password             = "${var.password}"
  proxmox_url          = "https://my-proxmox.my-domain:8006/api2/json"
  ssh_password         = "packer"
  ssh_timeout          = "15m"
  ssh_username         = "root"
  template_description = "Rocky 10, generated on ${timestamp()}"
  template_name        = "rocky-10"
  username             = "${var.username}"
}

build {
  sources = ["source.proxmox-iso.rocky-kickstart"]