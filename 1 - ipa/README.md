# FreeIPA Setup
In this step, you'll use Ansible to create and provision a new VM from your template. Then, you'll use the official FreeIPA Ansible role to configure a FreeIPA server to provide DNS resolution and authentication.

First, edit the inv and server.yml files. They are hardcoded to look for your FreeIPA server at 192.168.5.4 with a realm of CMK.LAN. Adjust these values as necessary. Maybe I'll make them variables someday.

Then, simply run `ansible-playbook -k -i inv server.yml` and hope for the best. After completion, your FreeIPA server should be available at HTTPS port 443 with the username `admin` and the password provided in inv as ipaadmin_password.
