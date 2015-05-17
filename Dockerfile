FROM ubuntu:14.04

RUN apt-get update; apt-get install -y software-properties-common

# https://wiki.ubuntu.com/ServerTeam/CloudArchive
RUN add-apt-repository -y cloud-archive:kilo

RUN apt-get update; apt-get install -y \
    supervisor \
    memcached \
    swift \
    swift-proxy \
    swift-object \
    swift-account \
    swift-container \
    swift-object

# dependencies for swift3
RUN apt-get install -y \
    git \
    python-dev \
    python-pip \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev

# to get a decently recent version of swift3, you have to git clone...
RUN cd /root; git clone https://github.com/stackforge/swift3.git
RUN cd /root/swift3; python setup.py install

#RUN pip install python_swiftclient

RUN mkdir -p /var/log/supervisor
COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY files/dispersion.conf /etc/swift/dispersion.conf
COPY files/rsyncd.conf /etc/rsyncd.conf
COPY files/account-server.conf /etc/swift/account-server.conf
COPY files/object-server.conf /etc/swift/object-server.conf
COPY files/container-server.conf /etc/swift/container-server.conf
COPY files/proxy-server.conf /etc/swift/proxy-server.conf
COPY files/swift.conf /etc/swift/swift.conf
COPY files/startmain.sh /usr/local/bin/startmain.sh

EXPOSE 8080
CMD ["bash", "/usr/local/bin/startmain.sh"]
