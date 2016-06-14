FROM ubuntu:16.04
MAINTAINER Kawin Viriyaprasopsook <bouroo@gmail>


RUN echo root:pass | chpasswd && \
	echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" >/etc/apt/apt.conf.d/docker-gzip-indexes && \
	apt-get update && \
	apt-get install -y \
	wget \
	locales && \
	dpkg-reconfigure locales && \
	locale-gen C.UTF-8 && \
	/usr/sbin/update-locale LANG=C.UTF-8 && \
	wget http://www.webmin.com/jcameron-key.asc && \
	apt-key add jcameron-key.asc && \
	echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list && \
	apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install -y webmin ntpdate && \
	apt-get autoclean


ENV LC_ALL C.UTF-8

EXPOSE 10000

VOLUME ["/etc/webmin"]

CMD /usr/bin/touch /var/webmin/miniserv.log && /usr/sbin/service webmin restart && /usr/bin/tail -f /var/webmin/miniserv.log
