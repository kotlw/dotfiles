#!/usr/bin/env bash
#
# Checks required dependencies. Creates symlinks.


declare -r DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# A warning will be shown if some of these binaries is missing.
declare -a REQUIRED_BIN=(
  "brew"
  "git"
  "alacritty"
  "tmux"
  "nvim"
  "randomq"
)

# Links description: "<source file path> = <destination file path>".
declare -a LINKS=(

)

function check_required_bins() {
  for bin in "${REQUIRED_BIN[@]}"; do
    if ! command -v "${bin}" &>/dev/null; then
      echo -e "\033[0;33mWARNING: ${bin} is missing\033[0m"
    fi
  done
}

function link() {
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

function main() {
  check_required_bins 
  link
}

main
