#!/bin/bash
set -e

# Only do devcontainer setup when running inside a container.
if [ ! -f /run/.containerenv ] && [ -z "$REMOTE_CONTAINERS" ] && [ ! -d /workspaces ]; then
    echo "Not a devcontainer — skipping devcontainer setup."
    exit 0
fi

# Stow editor config.
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
stow --dir="$DOTFILES_DIR" --target="$HOME/.config" --dotfiles nvim

# Start the 1Password SSH relay (host exposes the agent on TCP 2222 via LaunchAgent).
RELAY_SOCK=/tmp/1password-agent.sock
if ! [ -S "$RELAY_SOCK" ]; then
    start-stop-daemon --start --background --no-close --exec /usr/bin/socat -- \
        UNIX-LISTEN:"$RELAY_SOCK",fork,mode=777 \
        TCP:host.docker.internal:2222 >> /tmp/1password-relay.log 2>&1
fi

# Persist SSH_AUTH_SOCK for interactive shells.
ZSHRC="$HOME/.zshrc"
if ! grep -q "1password-agent.sock" "$ZSHRC" 2>/dev/null; then
    echo "export SSH_AUTH_SOCK=$RELAY_SOCK" >> "$ZSHRC"
fi
