#!/bin/bash

cp $ROOT_PATH/autoindex/autoindex_nginx_off.conf /etc/nginx/sites-available/localhost
service nginx restart
echo "autoindex off"