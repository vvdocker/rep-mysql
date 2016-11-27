FROM vvdocker/mha-node

RUN apt-get update

##########################
# my.cnf
##########################
COPY conf.d/my.cnf.in my.cnf.in
RUN m4 -DSERVERID=`date +%s` my.cnf.in > /etc/mysql/conf.d/my.cnf

##########################
# start up shell command
##########################
VOLUME ./init.d:/docker-entrypoint-initdb.d
