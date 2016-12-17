FROM vvdocker/node:dev5

##########################
# my.cnf
##########################
COPY conf.d/my.cnf.in my.cnf.in
RUN m4 -DSERVERID=`date +%s` my.cnf.in > /etc/mysql/conf.d/my.cnf
RUN chmod 775 -R /etc/mysql/conf.d

COPY ./init.d/startup.sql /docker-entrypoint-initdb.d/startup.sql

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 22 3306
CMD mysql_install_db --datadir=/var/lib/mysql --user=mysql  && supervisord -n
