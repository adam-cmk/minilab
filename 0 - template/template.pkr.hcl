packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "password" {
  type      = string
  default   = "supersecret"
  sensitive = true
}

variable "username" {
  type    = string
  default = "apiuser@pve"
}

variable "pvehost" {
  type = string
}

variable "nodename" {
  type    = string
  default = "pve"
}

source "proxmox-iso" "rocky-kickstart" {
  disks {
    disk_size    = "32G"
    storage_pool = "local-lvm"
    type         = "scsi"
  }
  scsi_controller          = "virtio-scsi-pci"
  http_directory           = "config"
  insecure_skip_tls_verify = true

  boot_iso {
    iso_file = "local:iso/Rocky-10.1-x86_64-boot.iso"
    unmount  = true
    type     = "scsi"
  }
  additional_iso_files {
    cd_files         = ["./config/*"]
    cd_label         = "OEMDRV"
    unmount          = true
    type             = "scsi"
    iso_storage_pool = "local"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  cpu_type = "host"
  cores    = 2
  os       = "l26"
  memory   = 2048


  node                 = "${var.nodename}"
  password             = "${var.password}"
  proxmox_url          = "${var.pvehost}"
  ssh_password         = "cmkadmin123"
  ssh_timeout          = "15m"
  ssh_username         = "root"
  template_description = "Rocky 10, generated on ${timestamp()}"
  template_name        = "rocky-10"
  username             = "${var.username}"
}

build {
  sources = ["source.proxmox-iso.rocky-kickstart"]
}