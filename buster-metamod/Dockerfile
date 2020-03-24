###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPDIR /home/steam/csgo-dedicated

COPY etc/entry.sh /
ADD etc/cfg.tar.gz "${STEAMAPPDIR}/csgo/"

WORKDIR "${STEAMAPPDIR}"

RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends --no-install-suggests \
      wget \
      ca-certificates \
 && cd csgo \
 && wget -qO- https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git971-linux.tar.gz | tar xvzf - \
 && chown -R steam:steam "${STEAMAPPDIR}" \
 && apt-get remove --purge -y \
      wget \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

USER steam

VOLUME "${STEAMAPPDIR}"

ENTRYPOINT /entry.sh

# Expose ports
EXPOSE 27015/tcp 27015/udp 27020/udp
