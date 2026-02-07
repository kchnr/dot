# LOCAL PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# Detect if inside vscode editors
if [[ "$TERM_PROGRAM" == "vscode" ]]; then

  PROMPT='$ '

  return
fi

# oh my zsh 
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git autojump) # Removed 'brew' to prevent path hijacking
source $ZSH/oh-my-zsh.sh

# autojump
[[ -s /home/pya/.autojump/etc/profile.d/autojump.sh ]] && source /home/pya/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u


# Set Arch System defaults first
export EDITOR='nvim'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vi'
fi
export LANG=en_US.UTF-8

# ==========================================
# 3. DEVELOPMENT TOOLS (Grouped)
# ==========================================


export PATH="$PATH:$HOME/.opencode/bin"

# --- Node.js & Web (NVM, PNPM, Bun) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"

#Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/pya/.bun/_bun" ] && source "/home/pya/.bun/_bun"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- Go ---
export PATH="$PATH:$HOME/go/bin"

# --- Lua ---
export PATH="$PATH:$HOME/.luarocks/bin"
alias lua=luajit
alias luarocks='luarocks --lua-version 5.1'
[[ -x "$(command -v luarocks)" ]] && eval $(luarocks --lua-version 5.1 path --bin)

# --- Rust (Cargo) ---
export PATH="$PATH:$HOME/.cargo/bin"

# --- Java & Gradle (SDKMAN) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# --- Mobile/Game Dev (Tauri, Android, MonoGame) ---
export ANDROID_HOME="$HOME/Android/Sdk"
[ -d "$ANDROID_HOME/ndk" ] && export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk | head -n 1)"
export MGFXC_WINE_PATH="$HOME/.winemonogame"

# ==========================================
# 4. ALIASES & CUSTOM SCRIPTS
# ==========================================
alias vi=nvim
alias vim=nvim
alias reba="git fetch --all --prune; git rebase origin/main"
alias deedo="uv run --project '$HOME/prj/deedo/' deedo"

# Personal/Secret overrides
[[ ! -f "$HOME/.personal-secret.sh" ]] || source "$HOME/.personal-secret.sh"

