# ~/.bashrc

# 1. Exit if not interactive (Standard Arch/Bash safety)
[[ $- != *i* ]] && return

# 2. Basic History and Completion
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# 3. Source your dev environment (Copy these from your zshrc)
# This ensures 'npm', 'cargo', 'go', etc., work in Bash too
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin"

# NVM / Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Envman (Since it's in both of your current files)
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# 4. Set a very simple prompt so you know you're in Bash
PS1='[\u@\h \W]\$ '

# 5. Core Aliases
alias vi=nvim
alias vim=nvim

transcribe() {
    local url="$1"
    local temp_file="local_process_$(date +%s)"

    echo "--- Fetching media ---"
    # yt-dlp handles the 'is it a video or audio' detection automatically
    yt-dlp -x --audio-format wav -o "$temp_file.wav" "$url"

    echo "--- Transcribing locally ---"
    # --device auto handles GPU (CUDA) vs CPU detection
    # --model distil-large-v3 is the 2026 'sweet spot' for speed/accuracy
    whisper-ctranslate2 "$temp_file.wav" --model distil-large-v3 --device auto --compute_type auto

    # Clean up
    rm "$temp_file.wav"
    echo "Done. Transcript saved in current directory."
}
