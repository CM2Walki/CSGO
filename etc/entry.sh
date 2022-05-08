#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login anonymous \
				+app_update "${STEAMAPPID}" \
				+quit

# Is the config missing?
if [ ! -f "${STEAMAPPDIR}/${STEAMAPP}/cfg/server.cfg" ]; then
	# Download & extract the config
	wget -qO- "${DLURL}/master/etc/cfg.tar.gz" | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"

	# Change hostname on first launch (you can comment this out if it has done its purpose)
	sed -i -e 's/{{SERVER_HOSTNAME}}/'"${SRCDS_HOSTNAME}"'/g' "${STEAMAPPDIR}/${STEAMAPP}/cfg/server.cfg"
fi

# Are we in a metamod container and is the metamod folder missing?
if  [ ! -z "$METAMOD_VERSION" ] && [ ! -d "${STEAMAPPDIR}/${STEAMAPP}/addons/metamod" ]; then
	LATESTMM=$(wget -qO- https://mms.alliedmods.net/mmsdrop/"${METAMOD_VERSION}"/mmsource-latest-linux)
	wget -qO- https://mms.alliedmods.net/mmsdrop/"${METAMOD_VERSION}"/"${LATESTMM}" | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"	
fi

# Are we in a sourcemod container and is the sourcemod folder missing?
if  [ ! -z "$SOURCEMOD_VERSION" ] && [ ! -d "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod" ]; then
	LATESTSM=$(wget -qO- https://sm.alliedmods.net/smdrop/"${SOURCEMOD_VERSION}"/sourcemod-latest-linux)
	wget -qO- https://sm.alliedmods.net/smdrop/"${SOURCEMOD_VERSION}"/"${LATESTSM}" | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"
fi

# Believe it or not, if you don't do this srcds_run shits itself
cd "${STEAMAPPDIR}"

# Check if autoexec file exists
# Passing arguments directly to srcds_run, ignores values set in autoexec.cfg
autoexec_file="${STEAMAPPDIR}/${STEAMAPP}/cfg/autoexec.cfg"

# Overwritable arguments
ow_args=""

# If you need to overwrite a specific launch argument, add it to this loop and drop it from the subsequent srcds_run call
if [ -f "$autoexec_file" ]; then
        # TAB delimited name    default
        # HERE doc to not add extra file
        while IFS=$'\t' read -r name default
        do
                if ! grep -q "^\s*$name" "$autoexec_file"; then
                        ow_args="${ow_args} $default"
                fi
        done <<EOM
sv_password	+sv_password "${SRCDS_PW}"
rcon_password	+rcon_password "${SRCDS_RCONPW}"
EOM
	# if autoexec is present, drop overwritten arguments here (example: SRCDS_PW & SRCDS_RCONPW)
	bash "${STEAMAPPDIR}/srcds_run" -game "${STEAMAPP}" -console -autoupdate \
				-steam_dir "${STEAMCMDDIR}" \
				-steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
				-usercon \
				+fps_max "${SRCDS_FPSMAX}" \
				-tickrate "${SRCDS_TICKRATE}" \
				-port "${SRCDS_PORT}" \
				+tv_port "${SRCDS_TV_PORT}" \
				+clientport "${SRCDS_CLIENT_PORT}" \
				-maxplayers_override "${SRCDS_MAXPLAYERS}" \
				+game_type "${SRCDS_GAMETYPE}" \
				+game_mode "${SRCDS_GAMEMODE}" \
				+mapgroup "${SRCDS_MAPGROUP}" \
				+map "${SRCDS_STARTMAP}" \
				+sv_setsteamaccount "${SRCDS_TOKEN}" \
				+sv_region "${SRCDS_REGION}" \
				+net_public_adr "${SRCDS_NET_PUBLIC_ADDRESS}" \
				-ip "${SRCDS_IP}" \
				+sv_lan "${SRCDS_LAN}" \
				+host_workshop_collection "${SRCDS_HOST_WORKSHOP_COLLECTION}" \
				+workshop_start_map "${SRCDS_WORKSHOP_START_MAP}" \
				-authkey "${SRCDS_WORKSHOP_AUTHKEY}" \
				"${ow_args}" \
				"${ADDITIONAL_ARGS}"
else
	# If no autoexec is present, use all parameters
	bash "${STEAMAPPDIR}/srcds_run" -game "${STEAMAPP}" -console -autoupdate \
				-steam_dir "${STEAMCMDDIR}" \
				-steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
				-usercon \
				+fps_max "${SRCDS_FPSMAX}" \
				-tickrate "${SRCDS_TICKRATE}" \
				-port "${SRCDS_PORT}" \
				+tv_port "${SRCDS_TV_PORT}" \
				+clientport "${SRCDS_CLIENT_PORT}" \
				-maxplayers_override "${SRCDS_MAXPLAYERS}" \
				+game_type "${SRCDS_GAMETYPE}" \
				+game_mode "${SRCDS_GAMEMODE}" \
				+mapgroup "${SRCDS_MAPGROUP}" \
				+map "${SRCDS_STARTMAP}" \
				+sv_setsteamaccount "${SRCDS_TOKEN}" \
				+rcon_password "${SRCDS_RCONPW}" \
				+sv_password "${SRCDS_PW}" \
				+sv_region "${SRCDS_REGION}" \
				+net_public_adr "${SRCDS_NET_PUBLIC_ADDRESS}" \
				-ip "${SRCDS_IP}" \
				+sv_lan "${SRCDS_LAN}" \
				+host_workshop_collection "${SRCDS_HOST_WORKSHOP_COLLECTION}" \
				+workshop_start_map "${SRCDS_WORKSHOP_START_MAP}" \
				-authkey "${SRCDS_WORKSHOP_AUTHKEY}" \
				"${ADDITIONAL_ARGS}"
fi
