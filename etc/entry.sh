#!/bin/bash

${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit

${STEAMAPPDIR}/srcds_run -game csgo -console -autoupdate -steam_dir ${STEAMCMDDIR} -steamcmd_script ${STEAMAPPDIR}/csgo_update.txt -usercon +fps_max $SRCDS_FPSMAX \
			-tickrate $SRCDS_TICKRATE -port $SRCDS_PORT +tv_port $SRCDS_TV_PORT +clientport $SRCDS_CLIENT_PORT -maxplayers_override $SRCDS_MAXPLAYERS +game_type $SRCDS_GAMETYPE +game_mode $SRCDS_GAMEMODE \
			+mapgroup $SRCDS_MAPGROUP +map $SRCDS_STARTMAP +sv_setsteamaccount $SRCDS_TOKEN +rcon_password $SRCDS_RCONPW +sv_password $SRCDS_PW +sv_region $SRCDS_REGION
