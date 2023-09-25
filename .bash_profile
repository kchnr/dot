PATH="/usr/local/bin:$PATH"

. "$HOME/.cargo/env"


source /Users/jean/.docker/init-bash.sh || true # Added by Docker Desktop

export PATH="/Users/jean/prj/clutch/clutch-cli:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
