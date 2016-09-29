#!/bin/bash
DIR=`dirname $(readlink -f $0)`
echo $DIR
docker run --rm -v $DIR/my-site:/var/www/html \
  -e WORDPRESS_DB_HOST=172.17.0.1 \
  -e WORDPRESS_DB_USER=wordpress_devops \
  -e WORDPRESS_DB_PASSWORD=docker \
  -e WORDPRESS_DB_NAME=wordpress_devops \
  -p 8080:80 \
  wordpress:4.5.2-apache
