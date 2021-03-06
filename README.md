# shellshock

## Dockerfile

```
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
COPY ./test-cgi.sh /var/www/cgi-bin/
RUN chmod 755 /var/www/cgi-bin/test-cgi.sh
COPY ./serve-cgi-bin.conf /etc/apache2/conf-available/serve-cgi-bin.conf
COPY ./000-default.conf /etc/apache2/site-available/000-default.conf
COPY ./supervisord.conf /supervisord.conf
EXPOSE 80
ENTRYPOINT ["supervisord", "-c", "/supervisord.conf"]
```

## Docker Build

```
sudo docker build -t shellshock .
```

## Docker Run

```
sudo docker run -it -p 8080:80 --name hackcat105 shellshock
```

## Youtube
[![shellshock](https://res.cloudinary.com/marcomontalbano/image/upload/v1646103481/video_to_markdown/images/youtube--R5uhbtoQknY-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/R5uhbtoQknY "shellshock")
