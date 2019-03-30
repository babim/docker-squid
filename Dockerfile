FROM babim/alpinebase:3.9-x86

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_DIR=/squid \
    SQUID_CONFIG_DIR=/etc/squid \
    SQUID_USER=squid \
    SOFT=squid

# download option
RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# install
RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Squid%20install/${SOFT}_install.sh | bash

EXPOSE 3128/tcp
#VOLUME ["${SQUID_CACHE_DIR}", "${SQUID_LOG_DIR}", "${SQUID_CONFIG_DIR}"]
VOLUME ["${SQUID_DIR}"]
ENTRYPOINT ["/docker-entrypoint.sh"]
