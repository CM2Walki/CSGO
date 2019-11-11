[![](https://img.shields.io/codacy/grade/e201fa6b35074864b200eaf558563a22.svg)](https://hub.docker.com/r/cm2network/csgo/) [![Docker Build Status](https://img.shields.io/badge/docker%20build-passing-brightgreen.svg)](https://hub.docker.com/r/cm2network/csgo/)<sup><sup>1</sup></sup> [![Docker Stars](https://img.shields.io/docker/stars/cm2network/csgo.svg)](https://hub.docker.com/r/cm2network/csgo/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/csgo.svg)](https://hub.docker.com/r/cm2network/csgo/) [![](https://images.microbadger.com/badges/image/cm2network/csgo.svg)](https://microbadger.com/images/cm2network/csgo)
# Supported tags and respective `Dockerfile` links
-	[`latest` (*buster/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster/Dockerfile)
-	[`metamod` (*buster-metamod/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster-metamod/Dockerfile)
-	[`sourcemod` (*buster-sourcemod/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster-sourcemod/Dockerfile)

# What is Counter-Strike: Global Offensive?
Counter-Strike: Global Offensive (CS: GO) expands upon the team-based action gameplay that it pioneered when it was launched 19 years ago. CS: GO features new maps, characters, weapons, and game modes, and delivers updated versions of the classic CS content (de_dust2, etc.).
This Docker image contains the dedicated server of the game.

>  [CS:GO](https://store.steampowered.com/app/730/CounterStrike_Global_Offensive/)

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/1/1b/CS-GO_Logo.svg/1920px-CS-GO_Logo.svg.png" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=csgo-dedicated -e SRCDS_TOKEN={YOURTOKEN} cm2network/csgo
```

Running multiple instances (increment SRCDS_PORT and SRCDS_TV_PORT):
```console
$ docker run -d --net=host -e SRCDS_PORT=27016 -e SRCDS_TV_PORT=27021 -e SRCDS_TOKEN={YOURTOKEN} --name=csgo-dedicated2 cm2network/csgo
```

`SRCDS_TOKEN` **is required to be listed & reachable;** [https://steamcommunity.com/dev/managegameservers](https://steamcommunity.com/dev/managegameservers)<br/><br/>
**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
SRCDS_RCONPW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_FPSMAX=300
SRCDS_TICKRATE=128
SRCDS_MAXPLAYERS=14
SRCDS_STARTMAP="de_dust2"
SRCDS_REGION=3
SRCDS_MAPGROUP="mg_active"
```
## Config
The image contains a copy of the official ESL config files from [here](https://play.eslgaming.com/download/26251762/). The files can be found in the following directory: */home/steam/csgo-dedicated/csgo/cfg*

If you want to learn more about configuring a CS:GO server check this [documentation](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Advanced_Configuration).

## Docker Hub Build
<sup>1</sup> The image is too large (> 10 GBs) to be created using automated build and is therefor pushed manually.

# Image Variants:
The `csgo` images come in three flavors, each designed for a specific use case.

## `csgo:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is a bare-minimum CSGO dedicated server containing no 3rd party plugins.<br/>

## `csgo:metamod`
This is a specialized image. It contains the plugin environment [Metamod:Source](https://www.sourcemm.net) which can be found in the addons directory. You can find additional plugins [here](https://www.sourcemm.net/plugins).

## `csgo:sourcemod`
This is another specialized image. It contains both [Metamod:Source](https://www.sourcemm.net) and the popular server plugin [SourceMod](https://www.sourcemod.net) which can be found in the addons directory. [SourceMod](https://www.sourcemod.net) supports a wide variety of additional plugins that can be found [here](https://www.sourcemod.net/plugins.php).
