#!/bin/zsh
source ~/.zprofile
repo_root="$1"

while [[ ! -d "${repo_root}/.git" && "$(dirname "${repo_root}")" != "${repo_root}" ]]; do
  repo_root="$(dirname "${repo_root}")"
done

if [[ "${repo_root}" == "/" ]]; then
  tmux display-message "unable to find .git folder"
else
  tmux popup -E -w 95% -h 95% "exec $SHELL -lc 'lazygit -p ${repo_root}'"
fi
