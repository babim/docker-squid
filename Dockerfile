FROM babim/debianbase

ENV SQUID_VERSION=3 \
    SQUID_CACHE_DIR=/var/spool/squid3 \
    SQUID_LOG_DIR=/var/log/squid3 \
    SQUID_DIR=/squid \
    SQUID_CONFIG_DIR=/etc/squid3 \
    SQUID_USER=proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid${SQUID_VERSION} \
 && mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist

COPY squid.conf /etc/squid3/squid.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# change to one directory
RUN mkdir /squid && mv ${SQUID_CACHE_DIR} ${SQUID_DIR}/cache && ln -s ${SQUID_DIR}/cache ${SQUID_CACHE_DIR} && \
    mv ${SQUID_LOG_DIR} ${SQUID_DIR}/log && ln -s ${SQUID_DIR}/log ${SQUID_LOG_DIR} \
    mv ${SQUID_CONFIG_DIR} ${SQUID_DIR}/config && ln -s ${SQUID_DIR}/config ${SQUID_CONFIG_DIR} \
    mkdir /etc-start && cp -R ${SQUID_DIR}/* /etc-start

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y --purge && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_DIR}", "${SQUID_LOG_DIR}", "${SQUID_DIR}", "${SQUID_CONFIG_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
