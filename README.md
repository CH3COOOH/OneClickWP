# OneClickWP
Deploy WordPress by one-click. Tested on Rocky Linux.

## Howto
Execute `start.sh` to deploy WordPress on your server:

```shell
bash start.sh
```

Then `docker` (container of WP), `nginx` and `certbot` will be deployed automatically. Port 80, 443, 8000 (access without Nginx reverse proxy) should be available.

## Notice
In some parts, the script will pause, where users' manually input are required:  
- Nginx configuration: your site's FQDN
- Firewall configuration
- Certbot configuration: select the target site