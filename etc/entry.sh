#!/bin/bash

set -euo pipefail

cd "${STEAMAPPDIR}"

cat <<EOF > "${STEAMAPPDIR}/csgo_update.txt"
@ShutdownOnFailedCommand 1
@NoPromptForPassword 1
login anonymous
force_install_dir "${STEAMAPPDIR}"
app_update 740 validate
quit
EOF

"${STEAMCMDDIR}/steamcmd.sh" +runscript "${STEAMAPPDIR}/csgo_update.txt"

if [[ "${1:-}" = --no-start ]]; then
  exit 0
fi

"${STEAMAPPDIR}/srcds_run" \
  -game csgo \
  -console \
  -autoupdate \
  -steam_dir "${STEAMCMDDIR}" \
  -steamcmd_script "${STEAMAPPDIR}/csgo_update.txt" \
  -usercon \
  +fps_max "${SRCDS_FPSMAX:-300}" \
  -tickrate "${SRCDS_TICKRATE:-128}" \
  -port "${SRCDS_PORT:-27015}" \
  +tv_port "${SRCDS_TV_PORT:-27020}" \
  +clientport "${SRCDS_CLIENT_PORT:-27005}" \
  -maxplayers_override "${SRCDS_MAXPLAYERS:-14}" \
  +game_type "${SRCDS_GAMETYPE:-0}" \
  +game_mode "${SRCDS_GAMEMODE:-1}" \
  +mapgroup "${SRCDS_MAPGROUP:-mg_active}" \
  +map "${SRCDS_STARTMAP:-de_dust2}" \
  +sv_setsteamaccount "${SRCDS_TOKEN}" \
  +rcon_password "${SRCDS_RCONPW:-changeme}" \
  +sv_password "${SRCDS_PW:-changeme}" \
  +sv_region "${SRCDS_REGION:-3}"
