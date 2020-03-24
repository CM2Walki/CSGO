###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPDIR /home/steam/csgo-dedicated

COPY etc/entry.sh /
ADD etc/cfg.tar.gz "${STEAMAPPDIR}/csgo/"

WORKDIR "${STEAMAPPDIR}"

RUN chown -R steam:steam "${STEAMAPPDIR}"

USER steam

VOLUME "${STEAMAPPDIR}"

ENTRYPOINT /entry.sh

EXPOSE 27015/tcp 27015/udp 27020/udp
