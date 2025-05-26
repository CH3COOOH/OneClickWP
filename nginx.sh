dnf install -y nginx
systemctl enable nginx
systemctl start nginx
read -p "Host: " usr_host

cat >./${usr_host}.conf << EOF
server {
    listen       80;
    listen       [::]:80;
    server_name  ${usr_host};
    location /
    {
      proxy_pass http://127.0.0.1:8000;
      add_header X-Frame-Options SAMEORIGIN;
      proxy_set_header Host \$host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_hide_header X-Frame-Options;
      rewrite /wp-admin$ \$scheme://\$host\$uri/ permanent;
    }
}
EOF

cp ${usr_host}.conf /etc/nginx/conf.d/
nginx -t
nginx -s reload
