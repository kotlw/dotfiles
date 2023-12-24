utils::exists() {
  if ! command -v $1 &> /dev/null; then
    echo "$1 could not be found"
    exit 1
  fi
}
