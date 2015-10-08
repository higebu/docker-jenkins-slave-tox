FROM alpine:edge
MAINTAINER Yuya Kusakabe <yuya.kusakabe@gmail.com>

RUN apk --update add bash sudo curl ca-certificates git build-base openssh openjdk7-jre \
    libffi-dev openssl-dev libbz2 libc6-compat ncurses-dev readline-dev \
    xz-dev zlib-dev sqlite-dev patch bzip2-dev expat-dev zlib-dev \
    gdbm-dev paxmark linux-headers tcl-dev ruby ruby-bundler ruby-dev \
    ruby-io-console ruby-json libxml2-dev libxslt-dev libarchive-tools rsync && \
    rm -rf /var/cache/apk/* && \
    echo "root:jenkins" | chpasswd && \
    sed -i 's:/bin/ash:/bin/bash:' /etc/passwd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    ssh-keygen -A

ADD install_tox.sh /
RUN /install_tox.sh && \
    rm /install_tox.sh

ADD install_vagrant.sh /
RUN /install_vagrant.sh && \
    rm /install_vagrant.sh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
