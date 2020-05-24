FROM cm2network/csgo:base

ENV METAMOD_VERSION 1.10

RUN set -x \
	&& LATEST=$(wget -qO- https://mms.alliedmods.net/mmsdrop/${METAMOD_VERSION}/mmsource-latest-linux) \
	&& wget -qO- https://mms.alliedmods.net/mmsdrop/${METAMOD_VERSION}/${LATEST} | tar xvzf - -C "${STEAMAPPDIR}/csgo"

# All other properties are inherited from the base image
