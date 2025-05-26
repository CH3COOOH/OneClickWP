dnf install -y snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
echo "Wait for 30s..."
sleep 30
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
certbot --nginx