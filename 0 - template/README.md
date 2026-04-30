# VM Template
In this step, you'll create a Rocky Linux 10 VM template using Hasicorp Packer and kickstart.

You'll want to use Podman or Docker on your workstation for this. I'll assume you're cool like me and running rootless Podman.

First, fill in the vars.pkrvars.hcl file. Second, download the latest Rocky 10 ISO and upload it to your Proxmox storage.  Then, run this command:

```
podman run \
    -v `pwd`:/workspace -w /workspace --rm \
    docker.io/hashicorp/packer:full \
    build template.pkr.hcl -var-file=vars.pkrvars.hcl
```