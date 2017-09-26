FROM centos:latest
MAINTAINER SAIHIA
LABEL Vendor="CentOS" \
      License=GPLv2 \
Version=2.4.6-40

USER root
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt php-xmlrpc unzip wget && \
    yum clean all  

EXPOSE 80

CMD systemctl start httpd && \
    systemctl start mariadb && \
    systemctl enable httpd && \
    systemctl enable mariadb 

ENTRYPOINT /bin/bash
