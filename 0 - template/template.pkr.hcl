variable "password" {
  type    = string
  default = "supersecret"
  sensitive = true
}

variable "username" {
  type    = string
  default = "apiuser@pve"
}

variable "pvehost" {
  type    = string
}

variable "nodename" {
  type    = string
  default = "pve"
}

source "proxmox-iso" "rocky-kickstart" {
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
    cd_files                 = ["./config/*"]
    cd_label                 = "OEMDRV"
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
  proxmox_url          = "${var.pvehost}"
  ssh_password         = "packer"
  ssh_timeout          = "15m"
  ssh_username         = "root"
  template_description = "Rocky 10, generated on ${timestamp()}"
  template_name        = "rocky-10"
  username             = "${var.username}"
}

build {
  sources = ["source.proxmox-iso.rocky-kickstart"]