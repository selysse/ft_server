#!/bin/bash

cp $ROOT_PATH/autoindex/nginx.conf /etc/nginx/sites-available/localhost
service nginx restart
echo "autoindex on"