# make this into an alias later
# alias xevs="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'"
alias matlabnd="matlab -nodesktop -nosplash"
alias laptopdisplayoff="xrandr --output eDP1 --off --output DP1-1 --primary"
alias laptopdisplayon="xrandr --output eDP1 --auto --output DP1-1 --auto"
#alias laptopdisplayleft="xrandr --output eDP1 --mode 1920x1080 --output DP1-1 --auto --right-of eDP1"
alias laptopdisplayleft="xrandr --output eDP1 --auto --output DP1-1 --auto --right-of eDP1"
alias hdmioff="xrandr --output HDMI1 --off"
alias dpoff="xrandr --output DP1-1 --off"
alias lsl="ls -l"

# ls only for directories
alias lsd='find ./ -maxdepth 1 -type d'

# sync matlab files between two directories
function matsync {
rsync -av --include='*.mat' --include='*.m' --include='*.q' --exclude='*' $1 $2
}

alias grabscreen="import -density 300 png:- | xclip -selection clipboard -t image/png"
alias kuvpn="sudo openconnect --juniper https://vpn.ku.edu.tr"
alias ucbvpn="sudo openconnect https://ucbvpn.berkeley.edu"
alias recordscreen="ffmpeg -f x11grab -s 1920x1080 -r 25 -i $DISPLAY   -f alsa -i default -strict -2 -b:v 200k -s 1280x720 screen_recording.mp4"
alias recordscreenpres="ffmpeg -f x11grab -s 1024x768 -r 25 -i $DISPLAY   -f alsa -i default -strict -2 -b:v 200k -s 1024x768 screen_recording.mp4"
alias syuaur="yaourt -Syu --aur --noconfirm"
