#!/bin/sh

# Log rotation
#date="$(date +%F-%H-%M-%S)"
#mv -v ../../logs.0/nwserverLog*.txt ../../log-archive/
#tar chfz ../../log-archive/$date.tar.gz ../../log-archive/*.txt
#rm ../../log-archive/nwserverLog*.txt
#rm ../../logs.0/nwnx.txt
#rm ../../development/*

#export LD_PRELOAD="./NWNX_Core.so"

#export NWNX_CORE_LOG_LEVEL=7

#export NWNX_ADMINISTRATION_SKIP=true # Note - live server doesn't skip
#export NWNX_JVM_SKIP=true
#export NWNX_LUA_SKIP=true
#export NWNX_METRICS_INFLUXDB_SKIP=true # Note - live server doesn't skip
#export NWNX_MONO_SKIP=true
#export NWNX_REDIS_SKIP=true
#export NWNX_WEBHOOK_SKIP=true
#export NWNX_APPEARANCE_SKIP=true
#export NWNX_AREA_SKIP=true
#export NWNX_DIALOG_SKIP=true
#export NWNX_DOTNET_SKIP=true
#export NWNX_EFFECT_SKIP=true
#export NWNX_ELC_SKIP=true
#export NWNX_ENCOUNTER_SKIP=true
#export NWNX_FEEDBACK_SKIP=true
#export NWNX_LUA_SKIP=true
#export NWNX_MAXLEVEL_SKIP=true
#export NWNX_REDIS_SKIP=true
#export NWNX_REGEX_SKIP=true
#export NWNX_TRACKING_SKIP=true
#export NWNX_OPTIMIZATIONS_SKIP=false
#export NWNX_SQL_SKIP=true



#export NWNX_OPTIMIZATIONS_ASYNC_LOG_FLUSH=true
#export NWNX_OPTIMIZATIONS_GAME_OBJECT_LOOKUP=true
#export NWNX_OPTIMIZATIONS_OBJECT_TAG_LOOKUP=true

#export NWNX_METRICS_INFLUXDB_HOST=NWNX_METRICS_INFLUXDB_HOST_PLACEHOLDER
#export NWNX_METRICS_INFLUXDB_PORT=NWNX_METRICS_INFLUXDB_PORT_PLACEHOLDER

#export NWNX_SQL_HOST=localhost
#export NWNX_SQL_USERNAME=
#export NWNX_SQL_PASSWORD= 
#export NWNX_SQL_DATABASE=nwn
#export NWNX_SQL_QUERY_METRICS=true

#export NWNX_RUBY_PRELOAD_SCRIPT=NWNX_RUBY_PRELOAD_SCRIPT_PLACEHOLDER
#export NWNX_RUBY_EVALUATE_METRICS=true

#export NWNX_TWEAKS_HIDE_CLASSES_ON_CHAR_LIST=true don't enable or else it makes the server cry, we're using rename plugin instead
#export NWNX_TWEAKS_COMPARE_VARIABLES_WHEN_MERGING=false
#export NWNX_TWEAKS_DISABLE_SHADOWS=true
#export NWNX_TWEAKS_DISABLE_PAUSE=true
#export NWNX_TWEAKS_DISABLE_QUICKSAVE=true
#export NWNX_TWEAKS_SNEAK_ATTACK_IGNORE_CRIT_IMMUNITY=false #It broke flanking sneak attacks
#export NWNX_TWEAKS_HIDE_DMS_ON_CHAR_LIST=true
#export NWNX_TWEAKS_STRIP_OVT_FROM_NOT_VISIBLE_OBJECT=true
#export NWNX_RENAME_ON_MODULE_CHAR_LIST=2
#export NWNX_RENAME_ON_PLAYER_LIST=true

./nwserver-linux \
  -module 'CopyObjectValidTest' \
  -maxclients 250 \
  -minlevel 1 \
  -maxlevel 30 \
  -pauseandplay 0 \
  -pvp 2 \
  -servervault 1 \
  -elc 0 \
  -ilr 0 \
  -gametype 3 \
  -oneparty 0 \
  -difficulty 3 \
  -autosaveinterval 0 \
  -playerpassword 'aredev' \
  -dmpassword 'aredev' \
  -servername 'aredev' \
  -publicserver 1 \
  -reloadwhenempty 0 \
  -port 5121 \
  -nwsyncurl 'http://nwsync.nwnarelith.com' \
  -nwsynchash 'NWSYNC_PLACEHOLDER' \
  "$@"

pid=$!
echo $pid > .pid
