FROM debian:stable-slim@sha256:f183f95e31b3a0d8144bfce58a5ba2b42df726a745d0cf03dd81e238c4861cc6

RUN apt-get update && \
    apt-get install -y exim4-daemon-light iproute2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done;

COPY entrypoint.sh /bin/
COPY set-exim4-update-conf /bin/

RUN chmod a+x /bin/entrypoint.sh && \
    chmod a+x /bin/set-exim4-update-conf

EXPOSE 25
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]
