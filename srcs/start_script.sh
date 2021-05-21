#!/bin/bash

WP_DB_NAME="wordpress"
WP_DB_USERNAME="gselyse"
WP_DB_PASSWORD="gselyse"
WP_ADMIN_USERNAME="admin"
WP_ADMIN_PASSWORD="admin"
WP_ADMIN_EMAIL="gselyse@student.21-school.ru"
WP_DOMAIN="wordpress.$SERVER_NAME"
MYSQL_ROOT_PASSWORD="root"

service mysql start

mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE USER '$WP_DB_USERNAME'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE DATABASE $WP_DB_NAME;
GRANT ALL ON $WP_DB_NAME.* TO '$WP_DB_USERNAME'@'localhost';
EOF

service php7.3-fpm start
service nginx start

curl --insecure "https://localhost/wordpress/wp-admin/install.php?step=2" \
  --data-urlencode "weblog_title=$WP_DOMAIN"\
  --data-urlencode "user_name=$WP_ADMIN_USERNAME" \
  --data-urlencode "admin_email=$WP_ADMIN_EMAIL" \
  --data-urlencode "admin_password=$WP_ADMIN_PASSWORD" \
  --data-urlencode "admin_password2=$WP_ADMIN_PASSWORD" \
  --data-urlencode "pw_weak=on" \
  --data-urlencode "blog_public=0"  

bash
