#!/bin/bash

if [ "${DEBUGGING}" = "true" ]; then
	set -o xtrace
fi

set -o errexit
set -o nounset
set -o pipefail

CFG_PATH="${SERVER_PATH}/garrysmod/cfg/gmodserver.cfg"

function configReplace() {
	source="$1"
	target="$source \"$2\""
	
	count=$(grep -Poc "($source).+" "${CFG_PATH}")
	
	echo "[initConfigMurder.sh]Request for replacing $source to $target, source is found $count times"
	
	if [ "$count" == "1" ]; then
		source=$(grep -Po "($source).+" "${CFG_PATH}" | sed 's/\\/\\\\/g' | sed 's/\//\\\//g')
		target=$(echo "$target" | sed 's/\\/\\\\/g' | sed 's/\//\\\//g')
		sed -i "s/$source/$target/g" "${CFG_PATH}"
		
	elif [ "$count" == "0" ]; then
		echo "" >> "${CFG_PATH}"
		echo "$target" >> "${CFG_PATH}"
		
	else
		echo "[initConfigMurder.sh]can't set $1 because there are multiple in"
	fi
}

# Set murder specific ConVars
murder_con_vars=(
    mu_scoreboard_show_admins
    mu_show_bystander_tks
    mu_allow_admin_panel
    mu_tk_penalty_time
    mu_murderer_fogtime
    mu_flashlight_battery
    mu_delay_after_enough_players
    mu_localchat
    mu_localchat_range
    mu_disguise
    mu_disguise_removeonkill
    mu_moveafktospectator
    mu_show_spectate_info
    mu_roundlimit
)

get_value()
{
    variable_name=$1
    variable_value=""
    if set | grep -q "^$variable_name="; then
        eval variable_value="\$$variable_name"
    fi
    echo "$variable_value"
}

for con_var in "${murder_con_vars[@]}"; do
    env_var_name=$(echo "$con_var" | tr a-z A-Z)
    env_var_value=$(get_value "$env_var_name")
    if [ -n "$env_var_value" ]; then
	    configReplace "$con_var" "$env_var_value"
    fi
done
