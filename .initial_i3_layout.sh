#!/bin/bash

# https://github.com/yedhink
# Feel free to share with your friends

# install wmctrl. Its a prerequisite to make this script work.

# Launch it in your i3 config file
# exec --no-startup-id ~/.config/i3/init_workspace.sh
#
# obviously, make it executable : # chmod +x init_workspace.sh
# HAVE FUN !

# App you want to start :
apps=(
 #if you're using urxvt then replace st with that	
 "/snap/bin/brave" "/usr/local/bin/alacritty" "/usr/bin/teams" "/usr/bin/nautilus"
)

# Which workspace to assign your wanted App :
workspaces=(
"1: Web" "2: Coding" "3: communications" "5:files"
)

# counter of opened windows
owNB=$(wmctrl -l | wc -l)
already_opened=$(wmctrl -l | wc -l)
# echo $already_opened
# add paths of apps to array
arr=()
# arr+=( '/usr/bin/' )

for iwin in ${!apps[*]}
do
    echo "$owNB"
    echo "$iwin"
    sum=$(($iwin + $already_opened))
    echo $sum
    echo '=='
    while [ "$owNB" -lt "$sum" ] # wait before start other programs
    do
        owNB=$(wmctrl -l | wc -l) # Get number of actual opened windows
    sum=$(($iwin + $already_opened))
    done
    echo "$owNB"
    echo "WAIT IS DONE!"

    i3-msg workspace ${workspaces[$iwin]} # move in wanted workspace
    ${apps[$iwin]} & # start the wanted app
done