yts() {
  local query=""
  local quality="best"
  local count=5
  
  while getopts "n:q:h" opt; do
    case $opt in
      n) 
        count="$OPTARG"
        if ! [[ "$count" =~ ^[0-9]+$ ]]; then
          echo "Error: Count must be a positive number" >&2
          return 1
        fi
        ;;
      q) 
        quality="$OPTARG" 
        ;;
      h) 
        echo "Usage: yts [OPTIONS] \"search query\""
        echo ""
        echo "Options:"
        echo "  -n COUNT    Number of results (default: 5)"
        echo "  -q QUALITY  Video quality (default: best)"
        echo "  -h          Show this help"
        echo ""
        echo "Quality options: 360p, 480p, 720p, 1080p, 1440p, 4k, audio, best, worst"
        echo ""
        echo "Examples:"
        echo "  yts \"programming tutorial\""
        echo "  yts -n 10 \"music\""
        echo "  yts -q 720p \"documentary\""
        echo "  yts -n 3 -q audio \"podcast\""
        return 0
        ;;
      \?) 
        echo "Invalid option: -$OPTARG" >&2
        echo "Use 'yts -h' for help"
        return 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument" >&2
        return 1
        ;;
    esac
  done
  
  shift $((OPTIND-1))
  
  query="$1"
  
  if [ -z "$query" ]; then
    echo "Usage: yts [OPTIONS] \"search query\""
    echo "Quality: 360p, 480p, 720p, 1080p, 1440p, 4k, audio, best, worst"
    echo "Use 'yts -h' for help"
    return 1
  fi
  
  OPTIND=1
  
  case "$quality" in
    1080p) format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
    720p) format="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
    480p) format="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
    1440p) format="bestvideo[height<=1440]+bestaudio/best[height<=1440]" ;;
    4k) format="bestvideo[height<=2160]+bestaudio/best[height<=2160]" ;;
    360p) format="bestvideo[height<=360]+bestaudio/best[height<=360]" ;;
    audio) format="bestaudio" ;;
    best) format="bestvideo+bestaudio/best" ;;
    worst) format="worst" ;;
    *) format="bestvideo+bestaudio/best" ;;
  esac
  
  yt-dlp --print "(%(uploader)s) %(title)s [%(duration_string)s] Views: %(view_count)s |%(webpage_url)s" "ytsearch${count}:${query}" | fzf | cut -d'|' -f2 | xargs mpv --ytdl-format="$format"
}
