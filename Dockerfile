FROM centos/systemd

MAINTAINER "Your Name" <you@example.com>

RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt php-xmlrpc unzip wget && \
    yum clean all
RUN systemctl enable mariadb.service
RUN cd /var/www/html && wget http://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz
#RUN systemctl enable mysqld.service
RUN cd /var/www/html/wordpress && cp wp-config-sample.php wp-config.php
RUN sed -i 's@wordpress@wordpress@' /var/www/html/wordpress/wp-config.php && \
    sed -i 's@wordpressuser@wordpress@' /var/www/html/wordpress/wp-config.php && \
    sed -i 's@password@password@' /var/www/html/wordpress/wp-config.php && \
    curl https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php

ADD mariadb.sql /root
ADD mariadb2.sql /root
ADD server.cnf /root
ADD mariadb.sh /root
#ADD wp-config.php /var/www/wordpress

RUN /root/mariadb.sh

EXPOSE 80
#RUN /root/mariadb.sh
CMD ["/usr/sbin/init"]
#ENTRYPOINT /root/mariadb.sh && /bin/bash
