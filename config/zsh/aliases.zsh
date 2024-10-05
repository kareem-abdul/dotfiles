alias ls='ls --color --group-directories-first'
alias la='ls --color -A --group-directories-first'
alias l='ls --color -al --group-directories-first'
alias ll='ls --color -al'

alias h='history | tail'

alias {hostname2ip,h2ip}='dig +short'

alias zshconf="vim ~/.zshrc"
alias tmuxconf="vim ~/.config/tmux/tmux.conf"
alias sshconf="vim ~/.ssh/config" 
alias gitconf="vim ~/.config/git/config"

if command -v apt &>/dev/null; then
    alias update='sudo apt update && sudo apt upgrade && sudo apt autoremove'
elif command -v pacman &> /dev/null; then
    alias update='sudo pacman -Syu'
fi
alias topmem='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias topcpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head'
# alias backup="sudo rsync -aAXv --progress --delete --exclude={'/proc/*','/boot/*','/dev/*','/home/kareem/.cache/*','/home/kareem/.local/share/Trash/*','/media/*','/mnt/*','/sys/*','/swapfile'} -e 'ssh -i \"$HOME/.ssh/dtomics_id_rsa\"' / root@dtomics:/mnt/hdd/backup"

alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias status='sudo systemctl status'
alias restart='sudo systemctl restart'

alias mvn='"$(pwd)/mvnw"'
alias notify='notify-send -t 1000 -u critical "Complete" && paplay /usr/share/sounds/freedesktop/stereo/complete.oga'

if [ "$XDG_SESSION_TYPE" = "x11" ]
then
    alias copy="xclip -sel clip"
    alias paste="wl-copy"
elif [ "$XDG_SESSION_TYPE" = "wayland" ]
then
    alias copy="wl-copy"
    alias paste="wl-paste"
else
    echo "not supported display server $XDG_SESSION_TYPE"
fi
alias v="nvim"


# docker containers
alias mysql="docker exec -it mysql mysql"
alias mongosh="docker exec -it mongodb mongosh"
alias redis-cli="docker exec -it redis redis-cli"
alias aws='docker run --rm  -v ~/.aws/:/root/.aws -v $(pwd):/aws amazon/aws-cli'
#alias node="docker run --rm -it -p ${PORT:-8080}:${PORT:-8080} -v $(pwd):/work -v $HOME/.npm:/.npm -v $HOME/.config:/.config -w /work node:lts-alpine3.15 node"
#alias npm="docker run --rm -it -p ${PORT:-8080}:${PORT:-8080} -v $(pwd):/work -v $HOME/.npm:/.npm -v $HOME/.config:/.config -w /work node:lts-alpine3.15 npm"
#alias mvn='docker run --rm -it -p ${PORT:-8080}:${PORT:-8080} -v $(pwd):/work -v $HOME/.m2:/root/.m2 -w /work maven:3.8.4-jdk-11 mvn'
alias youtube-dl='docker run -it --rm -v $(pwd):/dl -w /dl -u "$(id -u ${USER}):$(id -g ${USER})" youtube-dl youtube-dl --no-cache-dir'  
alias kafka='docker exec -it kafka-broker bash'
# alias nvim='docker run -it --rm -u nvim --name nvim-$(date "+%s") -v $(pwd):/home/nvim/app -w /home/nvim/app nvim nvim'


# if [ ! -d "$HOME/.venv/pre-commit" ]; then
#    echo "does not exist"
#    python3 -m venv $HOME/.venv/pre-commit
#    $HOME/.venv/pre-commit/bin/pip install pre-commit
# fi
# alias pre-commit=~/.venv/pre-commit/bin/pre-commit

# functions
timer() { 
 start=$(date "+%s"); 
 while true; do 
	 time="$(($(date "+%s") - $start))"; 
	 printf '%s\r' "$(date -u -d "@$time" "+%H:%M:%S")"; 
     sleep 0.1;
 done; 
}

function dps() {
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.Status}}"
}

function wdps() {
    watch -t  'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.Status}}"'
}

function dports() {
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.Ports}}"
}

if (( $+commands[fzf] )); then

    function dstart() {
        local BUFFER=$(\
            docker ps -a --format "table {{.Names}}\t{{.State}}\t{{.ID}}" \
                | tail -n +2 \
                | fzf --layout=reverse --height=50 --border=rounded --border-label="Choose container"\
                | awk "{print \$3}" \
        );
        [ ! -z "$BUFFER" ] && docker start $(echo "$BUFFER")    
    }

    function dkill() {
        local BUFFER=$(\
            docker ps --format "table {{.Names}}\t{{.State}}\t{{.ID}}" \
                | tail -n +2 \
                | fzf --layout=reverse --height=50 --border=rounded --border-label="Choose container"\
                | awk "{print \$3}" \
        );
        [ ! -z "$BUFFER" ] && docker kill $(echo "$BUFFER")
    }

    function dstop() {
        local BUFFER=$(\
            docker ps --format "table {{.Names}}\t{{.State}}\t{{.ID}}" \
                | tail -n +2 \
                | fzf --layout=reverse --height=50 --border=rounded --border-label="Choose container"\
                | awk "{print \$3}" \
        );

        [ ! -z "$BUFFER" ] && docker stop $(echo "$BUFFER")
    }

    function dexec() {
        local BUFFER=$(\
            docker ps --format "table {{.Names}}\t{{.State}}\t{{.ID}}" \
                | tail -n +2 \
                | fzf --layout=reverse --height=50 --border=rounded --border-label="Choose container"\
                | awk "{print \$3}" \
                | head -n 1 \
        );
        [ ! -z "$BUFFER" ] && docker exec -it $(echo "$BUFFER") $@
    }
fi

function start_tmux() {
    if which tmux &> /dev/null; then
        if [[ -z "$TMUX" && -z "$TERMINAL_CONTEXT" ]]; then
            if tmux run &>/dev/null; then
                tmux -2u attach
            else
                tmux -2u new
            fi
        fi
    fi
}


# transfer.sh  functions
# transfer() { gpg --no-symkey-cache -o- -ac "$1" | curl -H "Max-Downloads: 1" -T - https://transfer.sh/$(basename "$1") | tee /dev/null }
# dowload() { curl "$1" | gpg --no-symkey-cache -d -o $(basename "$1") }

