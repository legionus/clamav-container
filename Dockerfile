FROM fedora:latest

RUN \
       dnf -y update \
    && dnf -y install clamav-data clamav-scanner \
    && dnf clean all

RUN \
    set -x \
    \
    && sed -ri ' \
            s/Example/#Example/g; \
            s/#?User .*/User root/g; \
            s/#Foreground/Foreground/g; \
            s/#LogTime/LogTime/g; \
            s/#TCPSocket/#TCPSocket/g; \
            s/#?StreamMaxLength 10M/StreamMaxLength 50M/g; \
            s/#?MaxThreads 202/MaxThreads 50/g; \
            s/#ReadTimeout/ReadTimeout/g; \
            s/#DetectBrokenExecutables/DetectBrokenExecutables/g; \
            s/#LocalSocket/LocalSocket/g; \
            s/#?LocalSocketGroup .*/LocalSocketGroup root/g; \
            s/#?LocalSocketMode .*/LocalSocketMode 666/g; \
            ' /etc/clamd.d/scan.conf \
    \
    && ln -s /etc/clamd.d/scan.conf /etc/clamd.conf

VOLUME ["/var/lib/clamav","/var/run/clamd.scan"]

ENTRYPOINT ["clamd"]
CMD []
