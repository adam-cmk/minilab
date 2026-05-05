# VM Template
In this step, you'll create a Rocky Linux 10 VM template using Hasicorp Packer and kickstart.

You'll want to use Podman or Docker on your workstation for this. I'll assume you're cool like me and running rootless Podman.

First, fill in the vars.pkrvars.hcl file. Second, download the latest Rocky 10 ISO and upload it to your Proxmox storage.  Then, run this command:

```
podman run \
    -v "`pwd`":/workspace -w /workspace --rm \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    docker.io/hashicorp/packer:light \
    init .
```
This will download the Proxmox plugin, and only has to be done once.
Now, build the image:

```
podman run \
    -v "`pwd`":/workspace -w /workspace --rm \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    docker.io/hashicorp/packer:light \
    build -var-file=vars.pkrvars.hcl template.pkr.hcl
```