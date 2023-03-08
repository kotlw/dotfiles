#!/usr/bin/env bash
# Creates symlinks.

declare -r DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Links description: "<source file path> = <destination file path>".
declare -a LINKS=(
  "alacritty/alacritty.yml = $HOME/.config/alacritty/alacritty.yml"

  "tmux = $HOME/.config/tmux"

  "lvim/config.lua = $HOME/.config/lvim/config.lua"

  "hammerspoon = $HOME/.config/hammerspoon"

  "zsh/.zprofile = $HOME/.zprofile"
  "zsh/.zshrc = $HOME/.config/zsh/.zshrc"
)

function main() {
  for line in "${LINKS[@]}"; do
    local src="${line% = *}"
    local abs_src="${DIR}/${line% = *}"
    local dst="$(eval "echo ${line#* = }")"
    local dst_dir="$(dirname "${dst}")"

    if [[ "${abs_src}" != "$(readlink "${dst}")" ]]; then
      echo "Linking: ${src}"

      if [[ ! -d "${dst_dir}" ]]; then
        mkdir -p "${dst_dir}"
        echo "  mkdir -p ${dst_dir}" 
      fi

      ln -sf "${abs_src}" "${dst}"
      echo "  ln -sf '${abs_src}' '${dst}'"

    else
      echo "${src} has already linked, skipping..."
    fi

  done
}

main
