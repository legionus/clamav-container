FROM fedora:latest

RUN \
       dnf -y update \
    && dnf -y install clamav-server clamav-data-empty \
    && dnf clean all

COPY clamd.conf /etc/clamd.conf
COPY check_clamd.sh /usr/bin/check_clamd.sh

VOLUME ["/srv"]

#ENTRYPOINT ["clamd"]
CMD ["clamd"]
