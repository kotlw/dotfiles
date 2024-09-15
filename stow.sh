#!/bin/bash
source $(dirname "$0")/local/.local/lib/utils.sh
utils::exists "stow"

stow --no-folding -S alacritty zsh local nvim tmux aerospace
