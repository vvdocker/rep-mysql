FROM vvdocker/node:20161229

##########################
# my.cnf
##########################
COPY conf.d/my.cnf.in my.cnf.in
RUN m4 -DSERVERID=`date +%s` my.cnf.in > /etc/mysql/conf.d/my.cnf

RUN chmod 775 -R /etc/mysql/conf.d



COPY ./init.d/startup.sql /docker-entrypoint-initdb.d/startup.sql


RUN /etc/init.d/mysql restart && \
    mysql -uroot -proot  < /docker-entrypoint-initdb.d/startup.sql && \
    /etc/init.d/mysql stop

EXPOSE 22 3306
CMD supervisord -n
