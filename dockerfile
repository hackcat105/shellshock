FROM ubuntu:20.04

# for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get install -y libncurses5
RUN apt-get install -y iproute2
RUN apt-get -qq install -y apache2
RUN apt-get install -y supervisor
COPY ./bash /bin/bash
RUN a2enmod cgid

RUN mkdir /var/www/cgi-bin
COPY ./test-cgi /var/www/cgi-bin/
RUN chmod 755 /var/www/cgi-bin/test-cgi
COPY ./serve-cgi-bin.conf /etc/apache2/conf-available/serve-cgi-bin.conf
COPY ./000-default.conf /etc/apache2/site-available/000-default.conf
COPY ./supervisord.conf /supervisord.conf
EXPOSE 80
ENTRYPOINT ["supervisord", "-c", "/supervisord.conf"]
