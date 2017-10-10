FROM centos/systemd

MAINTAINER "Your Name" <you@example.com>

ARG user
ARG pass
ARG ip
ARG mail

RUN yum -y install httpd; php-cli; yum clean all; systemctl enable httpd.service
RUN yum -y install mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt php-xmlrpc unzip wget && \
    yum clean all
RUN systemctl enable mariadb.service

ADD mariadb.sql /root

ADD mariadb.sh /root

RUN cd /tmp && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --path=/var/www/html/wordpress
RUN /root/mariadb.sh $ip $user $pass $mail 

EXPOSE 80

CMD ["/usr/sbin/init"]

