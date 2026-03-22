# Set these in ~/.zshenv:
# export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

bindkey -e
alias vim=nvim
alias less=less -r
alias claude='TERM_PROGRAM=iTerm.app claude'
source $HOME/.local/bin/env

export EDITOR=nvim
export GIT_EDITOR=nvim
export GOPATH="${HOME}/go"
export PATH="${PATH}:$GOPATH/bin"

export GREP_COLOR='38;2;192;202;245;48;2;54;74;130'

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# --- Fix invisible $VARS while typing in dark themes (Ghostty/Molokai) ---
# Known parameters ($SHELL, $HOME, etc.)
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
ZSH_HIGHLIGHT_STYLES[parameter]='fg=244'

# Unknown/incomplete tokens while typing ($FOO before it’s known/valid)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=240'

# If your setup highlights "$..." as an argument token while typing
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=244'
ZSH_HIGHLIGHT_STYLES[dollar-dollar-quoted-argument]='fg=244'
ZSH_HIGHLIGHT_STYLES[unknown-token]+='bg-235'

# Optional: iTerm2-like subtle background lift for "unknown" tokens
ZSH_HIGHLIGHT_STYLES[unknown-token]+='bg=235'

