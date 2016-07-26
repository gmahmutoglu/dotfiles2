#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status.conf | while :
do
        read line
        vol="$(ponymix get-volume)"
	if ponymix is-muted; then
		vol="muted (${vol}%)"
	else	
		vol="volume ${vol}%"
	fi

        if [ "$(pidof ncmpcpp)" ]; then
            musicstatus=$(mpc --format="%artist% // %album% // %title%" | head -1)
        elif [ "$(pidof cmus)" ]; then
            artist=$(cmus-remote -Q | grep 'tag artist ' | cut -d ' ' -f3-)
            album=$(cmus-remote -Q | grep 'tag album ' | cut -d ' ' -f3-)
            song=$(cmus-remote -Q | grep 'tag title ' | cut -d ' ' -f3-)
            musicstatus="${DT} ${artist} // ${album} // ${song}"
        elif [ "$(pidof spotify)" ]; then
            artist=$(sp current | grep '^Artist' | cut -d ' ' -f8-)
            album=$(sp current | grep 'Album\>' | cut -d ' ' -f9-)
            song=$(sp current | grep 'Title' | cut -d ' ' -f9-)
            musicstatus="${DT} ${artist} // ${album} // ${song}"
        fi
        musicstatus=$(echo ${musicstatus} | sed -e 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
       	echo "${musicstatus} | ${vol} | $line" || exit 1
       	#printf "%-0s %s" "${artist} - ${song}" 	"| ${vol} | $line" || exit 1

done
