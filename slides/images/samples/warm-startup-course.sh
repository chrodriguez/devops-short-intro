#!/bin/bash
DIR=`dirname $0`
cd $DIR/01-capistrano && vagrant destroy -f && vagrant up
cd $DIR/02-vagrant/01-simple && vagrant destroy -f
cd $DIR/02-vagrant/02-multi-machines && vagrant destroy -f
cd $DIR/02-vagrant/03-aws && vagrant destroy -f
cd $DIR/03-docker && docker-compose stop && docker-compose rm -f
cd $DIR/04-chef && vagrant destroy -f

echo "Revisar el server de chef y rancher"
