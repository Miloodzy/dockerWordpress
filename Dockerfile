FROM centos:latest
MAINTAINER SAIHIA
LABEL Vendor="CentOS" \
      License=GPLv2 \
Version=2.4.6-40

ENV MYSQL_ROOT_PASSWORD zboub

USER root
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt php-xmlrpc unzip wget && \
    yum clean all  

ADD mariadb.sql mariadb.sql
ADD server.cnf /dockerEngine/wordpress/server.cnf
ADD mariadb.sh /dockerEngine/wordpress/mariadb.sh

EXPOSE 80

CMD ["systemctl start httpd"]
CMD ["systemctl start mariadb"]
CMD ["systemctl enable httpd"]
CMD ["systemctl enable mariadb"]
CMD ["systemctl start mysqld"] 

#RUN ["/usr/bin/mysql_install_db --datadir="/var/lib/mysql" --user=mysql"]
#RUN ["/usr/bin/mysqld_safe --datadir="/var/lib/mysql" --socket="/var/lib/mysql/mysql.sock" --user=mysql  >/dev/null 2>&1 &"]
#RUN ["/usr/bin/mysqladmin -u root password zboub"]
CMD ["tail -f /var/log/mariadb/mariadb.log"]

ENTRYPOINT /bin/bash

EXPOSE 3306
CMD ["/root/mariadb.sh"] 
