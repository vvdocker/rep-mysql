FROM vvdocker/mha-node:24

#RUN apt-get update

##########################
# my.cnf
##########################
COPY conf.d/my.cnf.in my.cnf.in
RUN m4 -DSERVERID=`date +%s` my.cnf.in > /etc/mysql/conf.d/my.cnf
RUN chmod 775 -R /etc/mysql/conf.d

RUN mkdir -p /opt/mysql/server-5.6/data/
RUN mkdir -p /docker-entrypoint-initdb.d
COPY init.d/startup.sql /docker-entrypoint-initdb.d/startup.sql
RUN chmod -R 775 /docker-entrypoint-initdb.d


RUN sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# ssh
RUN mkdir .ssh
RUN chmod 700 .ssh
ADD id_rsa.pub ~/.ssh/id_rsa.pub

ADD ./init.d/startup.sql startup.sql
