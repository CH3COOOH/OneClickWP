db_pwd_root=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 16)
db_name=db_$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 5)
db_usr=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 8)
db_pwd=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 16)

cat >./docker-compose.wp.yml << EOF
version: '3.3'
services:
   db:
     image: mysql:latest
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: $db_pwd_root
       MYSQL_DATABASE: $db_name
       MYSQL_USER: $db_usr
       MYSQL_PASSWORD: $db_pwd
   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8000:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: $db_usr
       WORDPRESS_DB_PASSWORD: $db_pwd
       WORDPRESS_DB_NAME: $db_name
volumes:
    db_data: {}
EOF

dnf install -y podman-compose
systemctl enable podman
systemctl start podman
podman-compose -f ./docker-compose.wp.yml up -d