FROM debian:buster

RUN apt-get update && apt-get upgrade
RUN apt-get install -y tree vim 

RUN apt-get install -y nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php php-mysql php-fpm php-cli php-mbstring php-zip php-gd
RUN apt-get -y install wget curl openssl

RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz -O /tmp/phpmyadmin.tar.gz

ENV ROOT_PATH="/var/www/site"
ENV SERVER_NAME="localhost"

RUN mkdir -p $ROOT_PATH/phpmyadmin; \
	cd $ROOT_PATH/phpmyadmin; \
	tar xvzf /tmp/phpmyadmin.tar.gz --strip-components 1
RUN mkdir -p $ROOT_PATH/wordpress ;\
	cd $ROOT_PATH/wordpress ;\
	tar xvzf /tmp/wordpress.tar.gz --strip-components 1

RUN rm /tmp/wordpress.tar.gz ;\
	rm /tmp/phpmyadmin.tar.gz
RUN chown -R www-data:www-data $ROOT_PATH/wordpress/; \
	chmod -R 777 $ROOT_PATH/wordpress/wp-content

COPY ./srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
RUN mkdir $ROOT_PATH/autoindex
COPY ./srcs/wp-config.php $ROOT_PATH/wordpress
COPY ./srcs/nginx.conf $ROOT_PATH/autoindex
COPY ./srcs/autoindex_nginx_off.conf $ROOT_PATH/autoindex
COPY ./srcs/autoindex_on.sh .
COPY ./srcs/autoindex_off.sh .
COPY ./srcs/start_script.sh .

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=ru/ST=Moscow/L=Moscow/O=no/OU=no/CN=gselyse/" \
	-keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443

CMD sh -x start_script.sh