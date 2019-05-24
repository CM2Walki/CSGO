###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM cm2network/steamcmd

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 740
ENV STEAMAPPDIR /home/steam/csgo-dedicated

# Run Steamcmd and install CSGO
RUN set -x \
	&& ${STEAMCMDDIR}/steamcmd.sh \
		+login anonymous \
		+force_install_dir ${STEAMAPPDIR} \
		+app_update ${STEAMAPPID} validate \
		+quit \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir ${STEAMAPPDIR}'; \
		echo 'app_update ${STEAMAPPID}'; \
		echo 'quit'; \
	} > ${STEAMAPPDIR}/csgo_update.txt \
	&& cd ${STEAMAPPDIR}/csgo \ 
    	&& wget -qO- https://raw.githubusercontent.com/CM2Walki/CSGO/master/etc/cfg.tar.gz | tar xf -

ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=128 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
	SRCDS_MAXPLAYERS=14 \
	SRCDS_TOKEN=0 \
	SRCDS_RCONPW="changeme" \
	SRCDS_PW="changeme" \
	SRCDS_STARTMAP="de_dust2"

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR

# Set Entrypoint:
# 1. Update server
# 2. Start server
ENTRYPOINT ${STEAMCMDDIR}/steamcmd.sh \
                +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit \
		&& ${STEAMAPPDIR}/srcds_run \
			-game csgo -console -autoupdate -steam_dir ${STEAMCMDDIR} -steamcmd_script ${STEAMAPPDIR}/csgo_update.txt -usercon +fps_max $SRCDS_FPSMAX \
			-tickrate $SRCDS_TICKRATE -port $SRCDS_PORT -tv_port $SRCDS_TV_PORT -maxplayers_override $SRCDS_MAXPLAYERS +game_type 0 +game_mode 1 \
			+mapgroup mg_active +map $SRCDS_STARTMAP +sv_setsteamaccount $SRCDS_TOKEN +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW +sv_region $SRCDS_REGION

# Expose ports
EXPOSE 27015 27020 27005 51840
