OMP_HOME="${XDG_DATA_HOME}/ohmyposh"

if [ ! -d "$OMP_HOME" ]; then
    mkdir -p $OMP_HOME/{bin,themes}
    executable=$OMP_HOME/bin/oh-my-posh
    curl -s -f -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o $executable
    curl -s -f -L https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -o $OMP_HOME/themes.zip
    chmod +x $executable
    unzip -o -q $OMP_HOME/themes.zip -d $OMP_HOME/themes
    rm $OMP_HOME/themes.zip
fi

eval "$($OMP_HOME/bin/oh-my-posh init zsh --config ${XDG_CONFIG_HOME}/ohmyposh/zen.toml)"
