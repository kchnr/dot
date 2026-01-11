#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#       Hyprland 
#fi
if [[ `uname` == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Added by Toolbox App
export PATH="$PATH:/home/jean/.local/share/JetBrains/Toolbox/scripts"


# Added by swiftly
[[ ! -f "$HOME/.swiftly/env.sh" ]] || . "$HOME/.swiftly/env.sh"

export MGFXC_WINE_PATH="/home/pya/.winemonogame"
